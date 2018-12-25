//
//  ApiConsumerConfig.swift
//  ApiConsumer
//
//  Created by Michael Housh on 12/24/18.
//

import Vapor


public protocol ApiConsumer: Responder {
    
    var container: Container { get }
    var config: ApiConsumerConfig { get }
    var middlewares: [Middleware] { get }
    
    //func client() throws -> Client
    func send(_ req: Request) throws -> Future<Response>
    func send(_ req: ApiRequest) throws -> Future<Response>
    //func request(path: String, method: HTTPMethod, headers: HTTPHeaders) throws -> Request
}

extension ApiConsumer {
    
    public var middlewares: [Middleware] { return [] }
    
    public func send(_ req: Request) throws -> Future<Response> {
        let responder = middlewares.makeResponder(chainingTo: self)
        return try responder.respond(to: req)
    }
    
    public func send(_ req: ApiRequest) throws -> Future<Response> {
        return try self.send(req.request(for: self))
    }
    
    public func respond(to req: Request) throws -> EventLoopFuture<Response> {
        return try req.client().send(req)
    }
}

