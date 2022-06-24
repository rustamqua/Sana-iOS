//
//  PostCategoryRequest.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 05.05.2022.
//

import Foundation

public struct PostCategoryRequest: Request {
    public typealias ReturnType = PostCategoryBody
    public var path: String = "/finance/"
    public var method: HTTPMethod = .post
    public var body: [String : Any]?
    
    public init(tableId: String, body: PostAccountBody) {
        self.path = "/finance/\(tableId)/account/"
        self.body = body.asDictionary
    }
}

public struct PostCategoryBody: Codable {
    public let title: String
    public let icon: String
    public let type: String
    public let table: String
    public let parent: String?
    
    public init(title: String, icon: String, type: String, table: String, parent: String?) {
        self.title = title
        self.icon = icon
        self.type = type
        self.table = table
        self.parent = parent
    }
}
