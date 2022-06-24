//
//  VerifyOTPRequest.swift
//  Networking
//
//  Created by Rustam-Deniz Emirali on 28.04.2022.
//

import Foundation

public struct VerifyOTPRequest: Request {
    public typealias ReturnType = String
    public var path: String = "/auth/register/verify"
    public var method: HTTPMethod = .post
    public var queryParams: [String : String]?
    
    public init(code: String) {
        self.queryParams = ["code": code]
    }
}
