//
//  PostTransactionRequest.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 05.05.2022.
//

import Foundation


public struct PostTransactionRequest: Request {
    public typealias ReturnType = PostTransactionBody
    public var path: String = "/finance/"
    public var method: HTTPMethod = .post
    public var body: [String : Any]?
    
    public init(tableId: String, body: PostAccountBody) {
        self.path = "/finance/\(tableId)/transaction/"
        self.body = body.asDictionary
    }
}

public struct PostTransactionBody: Codable {
    public let date: String
    public let amount: String
    public let notes: String
    public let type: String
    public let merchant: String
    public let account: String
    public let category: String
    
    public init(date: String, amount: String, notes: String, type: String, merchant: String, account: String, category: String) {
        self.date = date
        self.amount = amount
        self.notes = notes
        self.type = type
        self.merchant = merchant
        self.account = account
        self.category = category
    }
}
