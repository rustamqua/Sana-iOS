//
//  PostAccountRequest.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 05.05.2022.
//

import Foundation

public struct PostAccountRequest: Request {
    public typealias ReturnType = PostAccountResponse
    public var path: String = "/finance/"
    public var method: HTTPMethod = .post
    public var body: [String : Any]?
    
    public init(tableId: String, body: PostAccountBody) {
        self.path = "/finance/\(tableId)/account/"
        self.body = body.asDictionary
    }
}

public struct PostAccountBody: Codable {
    public let name: String
    public let type: String
    public let currency: String
    public let initial_balance: String
    public let meta: Meta
    
    public init(name: String, type: String, currency: String, initialBalance: String) {
        self.name = name
        self.type = type
        self.currency = currency
        self.initial_balance = initialBalance
        self.meta = .init()
    }
    
    public struct Meta: Codable {
        
    }
}

public struct PostAccountResponse: Codable {
    public let name: String
    public let type: String
    public let currency: String
    public let initialBalance: String
}
