//
//  PostTableRequest.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 05.05.2022.
//

import Foundation

public struct PostTableRequest: Request {
    public typealias ReturnType = TableDTO
    public var path: String = "/finance/"
    public var method: HTTPMethod = .post
    public var body: [String : Any]?
    
    public init(body: PostTableBody) {
        self.body = body.asDictionary
    }
}

public struct PostTableBody: Codable {
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}
