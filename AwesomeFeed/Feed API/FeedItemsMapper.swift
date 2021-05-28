//
//  FeedItemsMapper.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 5/28/21.
//

import Foundation

internal final class FeedItemsMapper {
    private struct Root: Decodable {
        let items: [Item]
        
        var feed: [FeedItem] {
            return items.map({ $0.feedItem })
        }
    }

    private struct Item: Decodable {
        public let id: UUID
        public let description: String?
        public let location: String?
        public let image: URL
        
        var feedItem: FeedItem {
            return FeedItem(id: id, description: description, location: location, url: image)
        }
    }
    
    internal static func map(_ data: Data, response: HTTPURLResponse) -> RemoteFeedLoader.Results {
        guard response.statusCode == 200, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            return .failure(.invalidData)
        }
        
        let items = root.feed
        return .success(items)
    }
}
