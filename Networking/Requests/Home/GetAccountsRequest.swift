//
//  GetAccountRequest.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 05.05.2022.
//

import Foundation

public struct GetAccountsReqeust: Request {
    public typealias ReturnType = [AccountDTO]
    public var path: String = "/finance/"
    public var method: HTTPMethod = .get
    
    public init(tableId: String) {
        self.path = "/finance/\(tableId)/account/"
    }
}
