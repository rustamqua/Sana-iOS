//
//  LoginRequest.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 29.04.2022.
//

import Foundation

public struct LoginRequestBody: Codable {
    let email: String
    let password: String
    
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}

public struct LoginRequest: Request {
    public typealias ReturnType = String
    public var path: String = "/auth/login"
    public var method: HTTPMethod = .post
    public var body: [String : Any]?
    
    public init(body: LoginRequestBody) {
        self.body = body.asDictionary
    }
}
