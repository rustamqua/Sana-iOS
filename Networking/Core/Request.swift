//
//  Request.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 25.03.2022.
//
import Foundation
import Combine

public enum HTTPMethod: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case delete  = "DELETE"
}

public protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var body: [String: Any]? { get }
    var queryParams: [String: String]? { get }
    var headers: [String: String]? { get }
    associatedtype ReturnType: Codable
}

public extension Request {
    // Defaults
    var method: HTTPMethod { return .get }
    var queryParams: [String: String]? { return nil }
    var body: [String: Any]? { return nil }
    var headers: [String: String]? { return nil }
}

public extension Request {
    /// Transforms a Request into a standard URL request
    /// - Parameter baseURL: API Base URL to be used
    /// - Returns: A ready to use URLRequest
    func asURLRequest(baseURL: String, authToken: String?) -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL) else { return nil }
        urlComponents.path = "\(urlComponents.path)\(path)"
        if let queryParams = queryParams {
            let queryItems: [URLQueryItem] = queryParams.compactMap { .init(name: $0, value: $1) }
            urlComponents.queryItems = queryItems
        }
        
        guard let finalURL = urlComponents.url else { return nil }
        var request = URLRequest(url: finalURL)
        
        request.httpMethod = method.rawValue
        request.httpBody = requestBodyFrom(params: body)
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let authToken = authToken {
            request.setValue("Bearer \(authToken)", forHTTPHeaderField: "Authorization")
        }
        
        if let headers = headers {
            headers.forEach { key, value in
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        return request
    }
    
    /// Serializes an HTTP dictionary to a JSON Data Object
    /// - Parameter params: HTTP Parameters dictionary
    /// - Returns: Encoded JSON
    private func requestBodyFrom(params: [String: Any]?) -> Data? {
        guard let params = params else { return nil }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {
            return nil
        }
        return httpBody
    }
}
