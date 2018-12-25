//
//  BasicConsumer.swift
//  ApiConsumer
//
//  Created by Michael Housh on 12/25/18.
//

import Vapor


public class BasicConsumer: ApiConsumer {
    
    public var container: Container
    public var config: ApiConsumerConfig
    public var middlewares: [Middleware]
    
    public required init(container: Container, config: ApiConsumerConfig, using middlewares: [Middleware] = []) {
        self.container = container
        self.config = config
        self.middlewares = middlewares
    }
}
