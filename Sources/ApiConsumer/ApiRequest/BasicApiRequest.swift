//
//  BasicApiRequest.swift
//  ApiConsumer
//
//  Created by Michael Housh on 12/25/18.
//

import Vapor

public class BasicApiRequest: ApiRequest {
    
    public let method: HTTPMethod
    public let path: String
    public var headers: HTTPHeaders
    
    public init(path: String, method: HTTPMethod = .GET, headers: HTTPHeaders = .init()) {
        self.path = path
        self.method = method
        self.headers = headers
    }
}
