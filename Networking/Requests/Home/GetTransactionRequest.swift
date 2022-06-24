//
//  GetTransactionRequest.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 05.05.2022.
//

import Foundation

public struct GetTransactionReqeust: Request {
    public typealias ReturnType = TransactionDTO
    public var path: String = "/finance/"
    public var method: HTTPMethod = .get
    
    public init(tableId: String, transactionId: String) {
        self.path = "/finance/\(tableId)/transaction/\(transactionId)/"
    }
}
