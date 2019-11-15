//
//  ObservableArray.swift
//  ObservableArray
//
//  Created by Safx Developer on 2015/02/19.
//  Copyright (c) 2016 Safx Developers. All rights reserved.
//

import Foundation
import RxSwift





public struct ArrayChangeEvent<Element>
{
	public typealias Insert = Dictionary<Int, Element>
	public typealias Delete = Dictionary<Int, Element>
	public typealias Update = Dictionary<Int, (old: Element, new: Element)>
	
	public let inserted: Insert
	public let deleted: Delete
	public let updated: Update
	
	fileprivate init?(inserted: Insert = [:], deleted: Delete = [:], updated: Update = [:])
	{
		guard inserted.count + deleted.count + updated.count > 0 else { return nil }
		
		var _inserted = inserted
		var _deleted = deleted
		var _updated = updated
		
		// Map inserted and deleted to updated
		var updatedIndices = Set<Int>(_inserted.keys)
			.intersection(_deleted.keys)
			.subtracting(_updated.keys)
		while let index = updatedIndices.popFirst() {
			_updated[index] = (old: _deleted.removeValue(forKey: index)!,
							   new: _inserted.removeValue(forKey: index)!)
		}
		
		self.inserted = _inserted
		self.deleted = _deleted
		self.updated = _updated
	}
}





public final class ObservableArray<Element>: ExpressibleByArrayLiteral
{
	public typealias Event = ArrayChangeEvent<Element>
	
	internal var eventSubject: PublishSubject<Event>!
	internal var elementsSubject: BehaviorSubject<[Element]>!
	internal var _elements: [Element]
	public var elements: [Element] {
		get { return self._elements }
		set { self.replaceSubrange(self._elements.indices, with: newValue) }
	}
	
	
	
	
	
	public init()
	{
		self._elements = []
	}
	
	public init(count: Int, repeatedValue: Element)
	{
		self._elements = Array(repeating: repeatedValue, count: count)
	}
	
	required public init<S: Sequence>(_ s: S)
		where S.Iterator.Element == Element
	{
		self._elements = Array(s)
	}
	
	public required init(arrayLiteral elements: Element...)
	{
		self._elements = elements
	}
}





extension Array
{
	public typealias Observable = ObservableArray<Element>
	
	
	
	public func observable() -> Observable
	{
		return ObservableArray(self)
	}
}





extension ObservableArray
{
	public func rx_elements() -> Observable<[Element]>
	{
		if self.elementsSubject == nil {
			self.elementsSubject = BehaviorSubject(value: self._elements)
		}
		return self.elementsSubject
	}
	
	public func rx_events() -> Observable<Event>
	{
		if self.eventSubject == nil {
			self.eventSubject = PublishSubject()
		}
		return self.eventSubject
	}
	
	fileprivate func on(event: Event?)
	{
		if let event = event {
			self.elementsSubject?.onNext(self._elements)
			self.eventSubject?.onNext(event)
		}
	}
}





extension ObservableArray: Collection
{
	public var capacity: Int {
		return self._elements.capacity
	}
	
	public var startIndex: Int {
		return self._elements.startIndex
	}
	
	public var endIndex: Int {
		return self._elements.endIndex
	}
	
	public func index(after i: Int) -> Int
	{
		return self._elements.index(after: i)
	}
}





extension ObservableArray: MutableCollection
{
	public func reserveCapacity(_ minimumCapacity: Int)
	{
		self._elements.reserveCapacity(minimumCapacity)
	}
	
	public func append(_ newElement: Element)
	{
		self._elements.append(newElement)
		
		self.on(event: Event(inserted: [self.count - 1: newElement]))
	}
	
	public func append<S: Sequence>(contentsOf newElements: S)
		where S.Iterator.Element == Element
	{
		let end = self.count
		self._elements.append(contentsOf: newElements)
		
		guard end != self.count else { return }
		
		let inserted = (end..<self.count)
			.reduce(into: Event.Insert(), { $0[$1] = self[$1] })
		self.on(event: Event(inserted: inserted))
	}
	
	public func appendContentsOf<C: Collection>(_ newElements: C)
		where C.Iterator.Element == Element
	{
		guard !newElements.isEmpty else { return }
		
		let end = self._elements.count
		self._elements.append(contentsOf: newElements)
		
		let inserted = (end..<self.count)
			.reduce(into: Event.Insert(), { $0[$1] = self[$1] })
		self.on(event: Event(inserted: inserted))
	}
	
	@discardableResult
	public func removeLast() -> Element
	{
		let e = self._elements.removeLast()
		
		let deleted: Event.Delete = [self.count: e]
		self.on(event: Event(deleted: deleted))
		
		return e
	}
	
	public func insert(_ newElement: Element, at i: Int)
	{
		self._elements.insert(newElement, at: i)
		
		let inserted: Event.Insert = [i: newElement]
		self.on(event: Event(inserted: inserted))
	}
	
	@discardableResult
	public func remove(at index: Int) -> Element
	{
		let e = self._elements.remove(at: index)
		
		let deleted: Event.Delete = [index: e]
		self.on(event: Event(deleted: deleted))
		
		return e
	}
	
	public func removeAll(_ keepCapacity: Bool = false)
	{
		guard !self.isEmpty else { return }
		
		let deleted = self.enumerated()
			.reduce(into: Event.Delete(), { $0[$1.offset] = $1.element })
		
		self._elements.removeAll(keepingCapacity: keepCapacity)
		
		self.on(event: Event(deleted: deleted))
	}
	
	public func removeAll(where shouldBeRemoved: (Element) throws -> Bool) rethrows
	{
		guard !self.isEmpty else { return }
		
		let deleted = self.enumerated()
			.reduce(into: Event.Delete(), { $0[$1.offset] = $1.element })
		
		try self._elements.removeAll(where: shouldBeRemoved)
		
		self.on(event: Event(deleted: deleted))
	}
	
	public func insertContentsOf(_ newElements: [Element], atIndex i: Int)
	{
		guard !newElements.isEmpty else { return }
		
		self._elements.insert(contentsOf: newElements, at: i)
		
		let inserted = (i..<self.count)
			.reduce(into: Event.Insert(), { $0[$1] = self[$1] })
		self.on(event: Event(inserted: inserted))
	}
	
	public func popLast() -> Element?
	{
		guard let e = self._elements.popLast() else { return nil }
		
		let deleted: Event.Delete = [self.count: e]
		self.on(event: Event(deleted: deleted))
		
		return e
	}
}





extension ObservableArray: RangeReplaceableCollection
{
	public func replaceSubrange<C : Collection>(_ subRange: Range<Int>, with newCollection: C)
		where C.Iterator.Element == Element, C.Index == Index
	{
		let deleted = (subRange.lowerBound..<subRange.upperBound)
			.reduce(into: Event.Delete(), { $0[$1] = self[$1] })

		let oldCount = self.count
		self._elements.replaceSubrange(subRange, with: newCollection)
		let first = subRange.lowerBound
		let newCount = self.count
		let end = first + (newCount - oldCount) + subRange.count

		let inserted = (first..<end)
			.reduce(into: Event.Insert(), { $0[$1] = self[$1] })
		self.on(event: Event(inserted: inserted,
							 deleted: deleted))
	}
}





extension ObservableArray: CustomDebugStringConvertible
{
	public var description: String {
		return self._elements.description
	}
}





extension ObservableArray: CustomStringConvertible
{
	public var debugDescription: String {
		return self._elements.debugDescription
	}
}





extension ObservableArray: Sequence
{
	public subscript(index: Int) -> Element
	{
		get
		{
			return self._elements[index]
		}
		set
		{
			let oldValue = self[index]
			self._elements[index] = newValue
			
			let updated: Event.Update = [index: (old: oldValue, new: newValue)]
			self.on(event: Event(updated: updated))
		}
	}
	
	public subscript(bounds: Range<Int>) -> ArraySlice<Element>
	{
		get
		{
			return self._elements[bounds]
		}
		set
		{
			self.replaceSubrange(bounds, with: newValue)
		}
	}
	
	public subscript() -> ArraySlice<Element> {
		get
		{
			return self[self._elements.indices]
		}
		set
		{
			self[self._elements.indices] = newValue
		}
	}
}




