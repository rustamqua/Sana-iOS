//
//  GetTableByIdRequest.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 05.05.2022.
//

import Foundation

public struct GetTableByIdReqeust: Request {
    public typealias ReturnType = TableDetailsDTO
    public var path: String = "/finance/"
    public var method: HTTPMethod = .get
    public var queryParams: [String : String]?
    
    public init(id: String) {
        self.path = "/finance/\(id)/"
    }
}

public struct TableDetailsDTO: Codable {
    public let id: String
    public let name: String
    public let netWorth: Double
    public let accounts: AccountsDTO
    public let recentTransactions: [TransactionDTO]?
}

public struct AccountsDTO: Codable {
    public let cash: CashDTO
    public let bank: BankDTO
}

public struct CashDTO: Codable {
    public let balance: Double
    public let accounts: [AccountDTO]
}

public struct BankDTO: Codable {
    public let balance: Double
    public let accounts: [AccountDTO]
}

public struct AccountDTO: Codable, Hashable {
    public let id: String
    public let type: String
    public let currency: String
    public let name: String
    public let balance: Double
    
    public init(id: String, type: String, currency: String, name: String, balance: Double) {
        self.id = id
        self.type = type
        self.currency = currency
        self.name = name
        self.balance = balance
    }
}

public struct TransactionDTO: Codable, Hashable {
    public let id: String
    public let date: String?
    public let amount: String
    public let merchant: String
    public let category: String
    public let dateView: String
    public let type: String
    
    public init(id: String, date: String?, amount: String, merchant: String, category: String, dateView: String, type: String) {
        self.id = id
        self.date = date
        self.amount = amount
        self.merchant = merchant
        self.category = category
        self.dateView = dateView
        self.type = type
    }
}
