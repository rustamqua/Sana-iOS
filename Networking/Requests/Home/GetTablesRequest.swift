//
//  GetTablesRequest.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 05.05.2022.
//

import Foundation

public struct GetTablesRequest: Request {
    public typealias ReturnType = [TableDTO]
    public var path: String = "/finance/"
    public var method: HTTPMethod = .get
    
    public init() {}
}

public struct TableDTO: Codable {
    public let id: String
    public let name: String
}
