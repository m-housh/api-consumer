//
//  CRUDConsumer.swift
//  ApiConsumer
//
//  Created by Michael Housh on 12/24/18.
//

import Vapor


public protocol CRUDConsumer: ApiConsumer {
    
    var path: String { get }
    
    func all<T>() throws -> Future<T> where T: Content
    func save<T, C>(_ data: T) throws -> Future<C> where T: Content, C: Decodable
    func delete(id: UUID) throws -> Future<Void>
    func get<T>(id: UUID) throws -> Future<T> where T: Content
    
    
}

extension CRUDConsumer {
    
    private func request(path: String? = nil, method: HTTPMethod = .GET, headers: HTTPHeaders = .init()) throws -> Request {
        
        let basicRequest = BasicApiRequest(
            path: path ?? self.path,
            method: method,
            headers: headers
        )
        return try basicRequest.request(for: self)
    }
    
    public func all<T>() throws -> Future<T> where T: Content {
        //let req = try request(path: path, method: .GET, headers: .init())
        return try send(try request()).flatMap { try $0.content.decode(T.self) }
    }
    
    public func save<T, C>(_ data: T) throws -> Future<C> where T: Content, C: Decodable {
        let req = try request(method: .POST)
        try req.content.encode(data)
        return try send(req).flatMap { try $0.content.decode(C.self) }
    }
    
    public func delete(id: UUID) throws -> Future<Void> {
        let path = "/\(self.path)/\(id)"
        let req = try request(path: path, method: .DELETE)
        return try send(req).map { resp in
            guard resp.http.status == .ok else {
                throw Abort(.badRequest)
            }
        }
    }
    
    public func get<T>(id: UUID) throws -> Future<T> where T: Content {
        let path = "/\(self.path)/\(id)"
        let req = try request(path: path, method: .GET)
        return try send(req).flatMap { try $0.content.decode(T.self) }
    }
}
