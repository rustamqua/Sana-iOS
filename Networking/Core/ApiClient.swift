//
//  ApiClient.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 25.03.2022.
//

import Foundation
import Combine

public protocol APIClient: AnyObject {
    var baseURL: String { get }
    var networkDispatcher: NetworkDispatcher { get }
    var authToken: String? { get set }
        
    func dispatch<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError>
}

public class APIClientImpl: APIClient {
    public let baseURL: String
    public let networkDispatcher: NetworkDispatcher
    public var authToken: String?
    
    public init(baseURL: String,
                networkDispatcher: NetworkDispatcher = NetworkDispatcher()) {
        self.baseURL = baseURL
        self.networkDispatcher = networkDispatcher
    }
    /// Dispatches a Request and returns a publisher
    /// - Parameter request: Request to Dispatch
    /// - Returns: A publisher containing decoded data or an error
    public func dispatch<R: Request>(_ request: R) -> AnyPublisher<R.ReturnType, NetworkRequestError> {
        guard let urlRequest = request.asURLRequest(baseURL: baseURL, authToken: authToken) else {
            return Fail(outputType: R.ReturnType.self, failure: NetworkRequestError.badRequest).eraseToAnyPublisher()
        }
        typealias RequestPublisher = AnyPublisher<R.ReturnType, NetworkRequestError>
        let requestPublisher: RequestPublisher = networkDispatcher.dispatch(request: urlRequest)
        return requestPublisher.eraseToAnyPublisher()
    }
}
