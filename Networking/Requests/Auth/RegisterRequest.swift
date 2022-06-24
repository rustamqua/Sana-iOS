//
//  RegisterRequest.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 26.04.2022.
//

import Foundation

public struct RegisterRequest: Request {    
    public typealias ReturnType = String
    public var body: [String : Any]?
    public var path: String = "/auth/register"
    public var method: HTTPMethod = .post
    
    public init(body: [String: Any]) {
        self.body = body
    }
}

public struct RegisterRequestBody: Encodable {
    public let firstName: String
    public let lastName: String
    public let email: String
    
    public init(firstName: String, lastName: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}
