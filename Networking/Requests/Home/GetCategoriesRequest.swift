//
//  GetCategoriesRequest.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 05.05.2022.
//

import Foundation

public struct GetCategoriesReqeust: Request {
    public typealias ReturnType = [CategoryDTO]
    public var path: String = "/finance/"
    public var method: HTTPMethod = .get
    
    public init(tableId: String) {
        self.path = "/finance/\(tableId)/category/"
    }
}

public struct CategoryDTO: Codable, Hashable {
    public let id: String
    public let title: String
    public let type: String
    public let icon: String
    
    public init(id: String, title: String, type: StringLiteralType, icon: String) {
        self.id = id
        self.title = title
        self.type = type
        self.icon = icon
    }
}
