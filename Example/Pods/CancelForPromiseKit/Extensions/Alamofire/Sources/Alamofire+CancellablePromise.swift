import Alamofire
import PromiseKit

#if Carthage
import PMKAlamofire
#else
#if swift(>=4.1)
#if canImport(PMKAlamofire)
import PMKAlamofire
#endif
#endif
#endif

#if !CPKCocoaPods
import CancelForPromiseKit
#endif

extension Request: CancellableTask {
    /// `true` if the Alamofire request was successfully cancelled, `false` otherwise
    public var isCancelled: Bool {
        return task?.state == .canceling
    }
}

extension Alamofire.DataRequest {
    /// Wraps Alamofire.Response from Alamofire.response(queue:) as CancellablePromise<(Foundation.URLRequest, Foundation.HTTPURLResponse, Foundation.Data)>
    public func responseCC(_: PMKNamespacer, queue: DispatchQueue? = nil) -> CancellablePromise<(URLRequest, HTTPURLResponse, Data)> {
        return CancellablePromise(task: self, self.response(.promise, queue: queue))
    }
    
    /// Wraps Alamofire.DataResponse from Alamofire.responseData(queue:) as CancellablePromise<(Foundation.Data, PromiseKit.PMKAlamofireDataResponse)>
    public func responseDataCC(queue: DispatchQueue? = nil) -> CancellablePromise<(data: Data, response: PMKAlamofireDataResponse)> {
        return CancellablePromise(task: self, self.responseData(queue: queue))
    }
    
    /// Wraps the response from Alamofire.responseString(queue:) as CancellablePromise<(String, PromiseKit.PMKAlamofireDataResponse)>.  Uses the default encoding to decode the string data.
    public func responseStringCC(queue: DispatchQueue? = nil) -> CancellablePromise<(string: String, response: PMKAlamofireDataResponse)> {
        return CancellablePromise(task: self, self.responseString(queue: queue))
    }
    
    /// Wraps the response from Alamofire.responseJSON(queue:options:) as CancellablePromise<(Any, PromiseKit.PMKAlamofireDataResponse)>.  By default, the JSON decoder allows fragments, therefore 'Any' can be any standard JSON type (NSArray, NSDictionary, NSString, NSNumber, or NSNull).  If the received JSON is not a fragment then 'Any' will be either an NSArray or NSDictionary.
    public func responseJSONCC(queue: DispatchQueue? = nil, options: JSONSerialization.ReadingOptions = .allowFragments) -> CancellablePromise<(json: Any, response: PMKAlamofireDataResponse)> {
        return CancellablePromise(task: self, self.responseJSON(queue: queue, options: options))
    }
    
    /// Wraps the response from Alamofire.responsePropertyList(queue:options:) as CancellablePromise<(Any, PromiseKit.PMKAlamofireDataResponse)>.  Uses Foundation.PropertyListSerialization to deserialize the property list.  'Any' is an NSArray or NSDictionary containing only the types NSData, NSString, NSArray, NSDictionary, NSDate, and NSNumber.
    public func responsePropertyListCC(queue: DispatchQueue? = nil, options: PropertyListSerialization.ReadOptions = PropertyListSerialization.ReadOptions()) -> CancellablePromise<(plist: Any, response: PMKAlamofireDataResponse)> {
        return CancellablePromise(task: self, self.responsePropertyList(queue: queue, options: options))
    }
    
    #if swift(>=3.2)
    /// Wraps the response from Alamofire.responseDecodable(queue:) as CancellablePromise<Decodable>.  The Decodable is used to decode the incoming JSON data.
    public func responseDecodableCC<T: Decodable>(queue: DispatchQueue? = nil, decoder: JSONDecoder = JSONDecoder()) -> CancellablePromise<T> {
        return CancellablePromise(task: self, self.responseDecodable(queue: queue, decoder: decoder))
    }
    
    /// Wraps the response from Alamofire.responseDecodable() as CancellablePromise<(Decodable)>.  The Decodable is used to decode the incoming JSON data.
    public func responseDecodableCC<T: Decodable>(_ type: T.Type, queue: DispatchQueue? = nil, decoder: JSONDecoder = JSONDecoder()) -> CancellablePromise<T> {
        return CancellablePromise(task: self, self.responseDecodable(type, queue: queue, decoder: decoder))
    }
    #endif
}

extension Alamofire.DownloadRequest {
    /// Wraps Alamofire.Reponse.DefaultDownloadResponse from Alamofire.DownloadRequest.response(queue:) as CancellablePromise<Alamofire.Reponse.DefaultDownloadResponse>
   public func responseCC(_: PMKNamespacer, queue: DispatchQueue? = nil) -> CancellablePromise<DefaultDownloadResponse> {
        return CancellablePromise(task: self, self.response(.promise, queue: queue))
    }
    
    /// Wraps Alamofire.Reponse.DownloadResponse<Data> from Alamofire.DownloadRequest.responseData(queue:) as CancellablePromise<Alamofire.Reponse.DownloadResponse<Data>>
    public func responseDataCC(queue: DispatchQueue? = nil) -> CancellablePromise<DownloadResponse<Data>> {
        return CancellablePromise(task: self, self.responseData(queue: queue))
    }
}
