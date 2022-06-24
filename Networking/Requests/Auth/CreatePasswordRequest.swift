//
//  CreatePasswordRequest.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 28.04.2022.
//

import Foundation

public struct CreatePasswordBody: Encodable {
    let password: String
    
    public init(password: String) {
        self.password = password
    }
}

public struct CreatePasswordResponse: Codable {
    public let firstName: String
    public let email: String
    public let lastName: String
}

public struct CreatePasswordRequest: Request {    
    public typealias ReturnType = CreatePasswordResponse
    public var path: String = "/auth/register/finish"
    public var method: HTTPMethod = .post
    public var body: [String : Any]?
    
    public init(body: CreatePasswordBody) {
        self.body = body.asDictionary
    }
}
