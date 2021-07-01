//
//  FeedItemsMapper.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 5/28/21.
//

import Foundation

internal final class FeedItemsMapper {

    private struct Root: Decodable {
        let items: [RemoteFeedItem]
    }
    
    internal static func map(_ data: Data, response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
             throw RemoteFeedLoader.Error.invalidData
        }
        
        return root.items
    }
}
