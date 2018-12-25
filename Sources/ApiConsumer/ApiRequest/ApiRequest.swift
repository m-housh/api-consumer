//
//  ApiRequest.swift
//  ApiConsumer
//
//  Created by Michael Housh on 12/25/18.
//

import Vapor


public protocol ApiRequest {
    
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    
    func httpRequest(for consumer: ApiConsumer) throws -> HTTPRequest
    func request(for consumer: ApiConsumer) throws -> Request
}

extension ApiRequest {
    
    public var method: HTTPMethod { return .GET }
    public var path: String { return "" }
    public var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(name: .contentType, value: "application/json")
        return headers
    }
    
    public func httpRequest(for consumer: ApiConsumer) throws -> HTTPRequest {
        let urlString = "\(consumer.config.baseURL)/\(path)"
        guard let url = URL(string: urlString) else {
            try consumer.container.make(Logger.self).debug(
                "ApiRequest.httpRequest Error creating url"
            )
            throw Abort(.badRequest, reason: "Invalid url.")
        }
        return HTTPRequest(method: method, url: url, headers: headers)
    }
    
    public func request(for consumer: ApiConsumer) throws -> Request {
        return Request(http: try httpRequest(for: consumer), using: consumer.container)
    }
}



