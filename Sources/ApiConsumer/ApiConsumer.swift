//
//  ApiConsumerConfig.swift
//  ApiConsumer
//
//  Created by Michael Housh on 12/24/18.
//

import Vapor


public protocol ApiConsumer {
    
    var container: Container { get }
    var config: ApiConsumerConfig { get }
    func client() throws -> Client
    func send(_ req: Request) throws -> Future<Response>
    func request(path: String, method: HTTPMethod, headers: HTTPHeaders) throws -> Request
}

extension ApiConsumer {
    
    public func client() throws -> Client {
        return try container.client()
    }
    
    public func send(_ req: Request) throws -> Future<Response> {
        return try client().send(req)
    }
    
    public func request(path: String,
                        method: HTTPMethod = .GET,
                        headers: HTTPHeaders = .init()) throws -> Request {
        
        guard let url = URL(string: "\(config.baseURL)/\(path)") else {
            throw Abort(.badRequest)
        }
        
        var headers = headers
        if !headers.contains(name: .contentType) {
            headers.add(name: .contentType, value: "application/json")
        }
        
        let httpRequest = HTTPRequest(method: method, url: url, headers: headers)
        let request = Request(http: httpRequest, using: container)
        
        return request
    }
}

