//
//  BaseRequest.swift
//  Pokedex
//
//  Created by Jotam Leonardo on 8/4/22.
//

import Foundation
import BrightFutures
import Astral

public struct BaseRequest: Request {
    // MARK: - Stored Properties
    public let parameters: Parameters

    public let configuration: RequestConfiguration = PokeAPIConfiguration()

    public let method: HTTPMethod

    public let headers: Set<Header>

    public var cachePolicy: URLRequest.CachePolicy?

    public let pathComponents: [String]

    public init(
        parameters: Parameters = .none,
        method: HTTPMethod = .get,
        headers: Set<Header> = [],
        pathComponents: [String] = []
    ) {
        self.parameters = parameters
        self.method = method
        self.headers = headers
        self.pathComponents = pathComponents
    }
}
