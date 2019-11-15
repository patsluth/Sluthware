//
//  ViewController.swift
//  Sluthware
//
//  Created by patsluth on 12/19/2017.
//  Copyright (c) 2017 patsluth. All rights reserved.
//

import UIKit
import SceneKit
import simd

import Sluthware
//import FirebaseFirestore






public extension Math
{
	typealias Line<T> = (m: T, b: T)
		where T: Sluthware.FloatingPointType
	typealias Circle<T> = (hk: T, r: T)
		where T: Sluthware.FloatingPointType
}





public extension CGPoint
{
	static func slope(between pointA: CGPoint, and pointB: CGPoint) -> CGFloat
	{
		let m = (pointA.y - pointB.y) / (pointA.x - pointB.x)
		
		return m
	}
	
	static func distancebetween(pointA: CGPoint, and pointB: CGPoint) -> CGFloat
	{
		let rise = pointA.y - pointB.y
		let run = pointA.x - pointB.x
		//c^2 = a^2 + b^2
		let hypotenuseSquared = (rise * rise) + (run * run)
		
		return sqrt(hypotenuseSquared)
	}
}








/**
*  y = mx + b
*/
public struct Line
{
	var m: CGFloat
	var b: CGFloat
}



extension Line
{
	init(from pointA: CGPoint, to pointB: CGPoint)
	{
		let m = CGPoint.slope(between: pointA, and: pointB)
		// point slope form
		// y - y2 = m(x - x2)
		// y =  m(x - x2) + y2
		// y = mx - mx2 + y2
		let b = (m * -pointB.x) + pointB.y
		
		self.init(m: m, b: b)
	}
	
	func solve(forX x: CGFloat) -> CGFloat
	{
		// y = mx + b
		return (self.m * x) + self.b
	}
	
	func solve(forY y: CGFloat) -> CGFloat
	{
		// y = mx + b
		// y - b = mx
		// x = (y - b) / m
		return (y - self.b) / self.m
	}
}

extension Line: CustomStringConvertible
{
	public var description: String {
		return String(format: "y = (%1.2f)x + (%1.2f)", self.m, self.b)
	}
}

extension Line: CustomDebugStringConvertible
{
	public var debugDescription: String {
		return self.description
	}
}



/**
*  (x - h)^2 + (y - k)^2 = r^2
*/
public struct Circle
{
	var hk: CGPoint		// center
	var r: CGFloat		// radius
}

extension Circle
{
//	extern CGPoint SWMCircleSolveWithY(SWMCircle circle, CGFloat y)
//	{
//	b//(x - h)^2 expands to x^2 - 2h + h^2
//	SWMQuadratic xhExpanded = SWMQuadraticMake(1.0, (circle.hk.x * -2.0), (circle.hk.x * circle.hk.x));
//	//(y - k)^2 expands to y^2 - 2k + k^2
//	SWMQuadratic ykExpanded = SWMQuadraticMake(1.0, (circle.hk.y * -2.0), (circle.hk.y * circle.hk.y));
//
//	CGFloat xhSolved = SWMQuadraticSolveForValue(xhExpanded, y);
//	ykExpanded.c = ( ykExpanded.c + xhSolved -
//	(circle.r * circle.r)); //squared
//
//	return SWMQuadraticSolveRoots(ykExpanded);
//	}
//
//	SWMQuadratic SWMCircleIntersectionWithSWMLine(SWMCircle circle, SWMLine line)
//	{
//	//(x - h)^2 expands to x^2 - 2h + h^2
//	SWMQuadratic xhExpanded = SWMQuadraticMake(1.0, (circle.hk.x * -2.0), (circle.hk.x * circle.hk.x));
//	//(y - k)^2 expands to y^2 - 2k + k^2
//	//SWMQuadratic ykExpanded = SWMQuadraticMake(1.0, (circle.hk.y * -2.0), (circle.hk.y * circle.hk.y));
//
//	//sub y in (y - k)^2 with y = mx + b
//	// (mx + b - k)^2
//	SWMQuadratic ykSubbedAndExpanded = SWMQuadraticMake( (line.m * line.m), //squared
//	( (line.m * (line.b - circle.hk.y)) * 2.0 ),
//	( (line.b - circle.hk.y) * (line.b - circle.hk.y) ) //squared
//	);
//
//	SWMQuadratic simplified = SWMQuadraticAdd(xhExpanded, ykSubbedAndExpanded);
//	simplified.c -= (circle.r * circle.r); //squared
//
//	return simplified;
//	}
}

extension Circle: CustomStringConvertible
{
	public var description: String {
		return String(format: "(x - %1.2f)^2 + (y - %1.2f)^2 = (%1.2f)^2", self.hk.x, self.hk.y, self.r)
	}
}

extension Circle: CustomDebugStringConvertible
{
	public var debugDescription: String {
		return self.description
	}
}








/**
*  ax^2 + bx + c = 0
*/
public struct Quadratic
{
	var a: CGFloat
	var b: CGFloat
	var c: CGFloat
}

extension Quadratic
{
	func evaluate(for value: CGFloat) -> CGFloat
	{
		return (self.a * (value * value)) + (self.b * value) + (self.c)
	}
	
	func solveDescriminant() -> CGFloat
	{
		return (self.b * self.b) - (4.0 * self.a * self.c)
	}
	
	// TODO: throws
	func solveRoots() -> CGPoint
	{
		let descriminant = self.solveDescriminant()
		
		guard descriminant >= 0
			else {
			return CGPoint(x: CGFloat.nan, y: CGFloat.nan)
		}
		
		let numeratorAdd = -self.b + sqrt(descriminant)
		let numeratorSubtract = -self.b - sqrt(descriminant)
		let denomenator = 2.0 * self.a
		
		return CGPoint(x: numeratorAdd / denomenator,
					   y: numeratorSubtract / denomenator)
	}
	
	
	
	
	
	public static func +(lhs: Quadratic, rhs: Quadratic) -> Quadratic
	{
		return Quadratic(a: lhs.a + rhs.a,
						 b: lhs.b + rhs.b,
						 c: lhs.c + rhs.c)
	}
	
	public static func +=(lhs: inout Quadratic, rhs: Quadratic)
	{
		lhs = lhs + rhs
	}
}

extension Quadratic: CustomStringConvertible
{
	public var description: String {
		return String(format: "(%1.2f)x^2 + (%1.2f)x + (%1.2f) = 0", self.a, self.b, self.c)
	}
}

extension Quadratic: CustomDebugStringConvertible
{
	public var debugDescription: String {
		return self.description
	}
}


















class ACODABLE: Codable
{
	enum CodingKeys: String, CodingKey
	{
		case varA
		case varB
	}
	
	var varA: String = "A"
	var varB: String = "B"
}






class ViewController: UIViewController
{
	@IBOutlet fileprivate var label: UILabel!
	@IBOutlet fileprivate var imageView: UIImageView!
	@IBOutlet fileprivate var collectionView: UICollectionView!
	
	fileprivate var documentInteractionController: UIDocumentInteractionController? = nil
	
//	fileprivate var listeners = [SymbolBlock?]()
//	fileprivate var listeners = [WeakReference<Reference<SymbolBlock>>]()
//
//	typealias SymbolBlock = () -> Void
//
//	func addListener(_ symbolBlock: NonObjectObjectReference<SymbolBlock>?)
//	{
//		guard let symbolBlock = symbolBlock else { return }
////		guard !self.listeners.contains(symbolBlock) else { return }
//		self.listeners.append(WeakReference(symbolBlock))
//	}
	
	
	
	
	
	
	
	

	
	
//	var ns2: NSObject? = NSObject()
//	let closureA = NonObjectObjectReference<SymbolBlock>({
//		print("A")
//	})
	
    override func viewDidLoad()
    {
		var os = OrderedSet<Int>()
		os.add(0)
		os.add(1)
		os.add(2)
		os.insert(3, at: os.startIndex)
		print(os[safe: 1])
		
		
//		self.didMove(toParent: UIViewController?)
		
		
		
		
		
		
		super.viewDidLoad()
		
		var A: String = "A"
		var B: String = "B"
		var C: String = "C"
		
		var weakArray = [WeakReference<ValueReference<String>>]()
		
		var vrA: ValueReference? = ValueReference(A)
		var vrB: ValueReference? = ValueReference(B)
		var vrC: ValueReference? = ValueReference(C)
		
		weakArray.append(WeakReference(vrA))
		weakArray.append(WeakReference(vrB))
		weakArray.append(WeakReference(vrC))
		
		print(weakArray)
		
		vrA = nil
		
		weakArray = weakArray.filter { ($0.value != nil) }
		
		print(weakArray)
		
		self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
		
	
		
		
		
		
		
		
		
		
		
		let aaa = ["A": 1,
				 "B": 2,
				 "C": 3]
		let bbb: [Int: Int] = [:]
		let ccc = [1, 2, 3, 4]
		aaa[safe: aaa.index(forKey: "A")]
		ccc[safe: 0]
		print(aaa.random)
		print(bbb.random)
		print(ccc.random)
		
		
		
		
		
		
		
		
		
		
		
		
		if let image = UIImage(named: "fsociety") {
			let resizedImage = image.imageResizedTo(image.size / 2.0)
			print("image.size =", image.size, "resizedImage.size =", resizedImage.size)
			self.imageView.image = resizedImage
		}
		
		
		
		print(self.stringForClass)
		print(ViewController.stringForClass)
		
		
		
        // TODO: write tests for each class
//        print(UIColor.random)
//        print(Math.pi_2)
		
		
		
		let string = "  Pat    Yulia  "
		let trimmedString = string.trim(String.WhitespaceTrimOptions.All)
		print(String(format: "string = \"%@\"", string))
		print(String(format: "trimmedString = \"%@\"", trimmedString))
		
		
		
		print(Float.pi_2, Double.pi_2, CGFloat.pi_2)
		
		print("FloatingPointType degToRad(deg):",
			  Float.degToRad(deg: 180.0),
			  Double.degToRad(deg: 180.0),
			  CGFloat.degToRad(deg: 180.0))
		print("FloatingPointType toRad:",
			  Float(180.0).toRad,
			  Double(180.0).toRad,
			  CGFloat(180.0).toRad)
		print("FloatingPointType radToDeg(rad):",
			  Float.radToDeg(rad: 1.564),
			  Double.radToDeg(rad: 1.564),
			  CGFloat.radToDeg(rad: 1.564))
		print("FloatingPointType toDeg:",
			  Float(1.564).toDeg,
			  Double(1.564).toDeg,
			  CGFloat(1.564).toDeg)
		print("FloatingPointType randomSign:",
			  Float.randomSign,
			  Double.randomSign,
			  CGFloat.randomSign)
		print("FloatingPointType random:",
			  Float.random,
			  Double.random,
			  CGFloat.random)
		print("FloatingPointType random(_ range):",
			  Float.random((7.0..<11.0)),
			  Double.random((7.0..<11.0)),
			  CGFloat.random((7.0..<11.0)))
		
		
		
		
		print("IntegerType random(_ range):",
			  Int.random((7..<111)),
			  Int32.random((7..<111)))
		
		print(Int64(1).boolValue.toString,
			  Int64(0).boolValue.toString,
			  false.intValue(Int64.self),
			  true.intValue(Int64.self))
		
		
		
		
		
		let array1 = ["A", "B", "C"]
		let array2 = [0, 1, 2]
		let array3 = [0.0, 0.5, 1.0]
		let set1 = Set<String>(array1)
		let set2 = Set<Int>(array2)
		let set3 = Set<Double>(array3)
		
		print(array1.joined(by: ","))
		print(array2.joined(by: ","))
		print(array3.joined(by: ","))
		print(set1.joined(by: ","))
		print(set2.joined(by: ","))
		print(set3.joined(by: ","))
		
		let image = self.view.imageRepresentation()
		
//		let a: A! = nil
//		let aa = try? a.encodeDictionary(AnyHashable.self, Any.self)
		
		
		
//		var a: simd_float3 = simd_float3.zero
//		let b: simd_float3 = simd_float3.zero
//		let c: SCNFloat = 0.0
//		a *= c
//		let d = a * b
//		let e = b - c
//		let f = c + d
		
		
		
		print("%" + String(format: "%.2f", 5.01))
		
		
		let builder = StringBuilder()
			.append("PAT")
			.append(line: "PAT0")
			.append("YULIA0",
					(NSAttributedString.Key.foregroundColor, UIColor.red))
			.append(line: "PAT1",
					(NSAttributedString.Key.foregroundColor, UIColor.blue))
			.append(line: "YULIA1")
		
		self.label.attributedText = builder.attributed
		
		
		
		
		
		
		var a1 = [0, 1, 2, 3, 4]
		let s1 = Set(a1)
		a1.append(contentsOf: [0, 1, 2, 3, 4, 5])
		let s2 = Set(a1)
		
		print("SET TEST", s1 == s2)
    }
	
	override func viewDidAppear(_ animated: Bool)
	{
		super.viewDidAppear(animated)
	}
	
	lazy var cellColors: [UIColor] = {
		var colors = [UIColor]()
		for i in (0...10) {
			colors.append(UIColor.random)
		}
		return colors
	}()
}





extension ViewController: UICollectionViewDataSource
{
	func numberOfSections(in collectionView: UICollectionView) -> Int
	{
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return self.cellColors.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
	}
}





extension ViewController: UICollectionViewDelegateFlowLayout
{
	func collectionView(_ collectionView: UICollectionView,
						willDisplay cell: UICollectionViewCell,
						forItemAt indexPath: IndexPath)
	{
		cell.backgroundColor = self.cellColors[indexPath.item]
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
	{
		self.screenshot()
	}
	
	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize
	{
		return CGSize(width: 200, height: 200)
	}
	
	func screenshot()
	{
		let pdfData = self.collectionView.generatePDFDataFor(title: "PAT PAT",
											   titleFont: UIFont.systemFont(ofSize: 21.0),
											   headerViews: [self.imageView, self.imageView, self.imageView],
											   footerViews: [self.imageView, self.imageView, self.imageView])
		
		
		
		var fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("test.pdf")
		pdfData?.write(to: fileURL, atomically: true)
		
		print(fileURL)
//		let documentInteractionController = UIDocumentInteractionController(url: fileURL!)
//		documentInteractionController.delegate = self
//		documentInteractionController.presentOptionsMenu(from: self.imageView.frame,
//														 in: self.view,
//														 animated: true)
	}
}



public extension String
{
//	public func boundingRect(with size: CGSize,
//							 options: NSStringDrawingOptions = [],
//							 attributes: [NSAttributedStringKey : Any]? = nil,
//							 context: NSStringDrawingContext?) -> CGRect
//	{
//		return (self as NSString).boundingRect(with:options:attributes:context:)
//	}
//
//
}





