//
//  ApiConsumerConfig.swift
//  ApiConsumer
//
//  Created by Michael Housh on 12/24/18.
//

import Vapor

public protocol ApiConsumerConfig: Service {
    var baseURL: String { get }
}
