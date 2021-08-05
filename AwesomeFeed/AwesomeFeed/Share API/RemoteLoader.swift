//
//  RemoteLoader.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 8/4/21.
//

import Foundation

public final class RemoteLoader<Resource> {
    private let client: HTTPClient
    private let url: URL
    private let mapper: Mapper
    
    public enum Error: Swift.Error {
        case connectionError
        case invalidData
    }
    
    public typealias Result = Swift.Result<Resource, Swift.Error>
    public typealias Mapper = (Data, HTTPURLResponse) throws -> Resource
    
    public init(url: URL, client: HTTPClient, mapper: @escaping Mapper) {
        self.url = url
        self.client = client
        self.mapper = mapper
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(url: url, completion: { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case let .success((data, response)):
                completion(self.map(data, from: response))
            case .failure:
                completion(.failure(RemoteLoader.Error.connectionError))
            }

        })
    }
    
    private func map(_ data: Data, from response: HTTPURLResponse) -> Result {
        do {
            return .success(try mapper(data, response))
        } catch {
            return .failure(Error.invalidData)
        }
    }
}
