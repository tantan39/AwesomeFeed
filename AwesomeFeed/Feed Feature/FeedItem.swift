//
//  FeedItem.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 5/27/21.
//

import Foundation

public struct FeedItem: Equatable {
    public let id: UUID
    public let description: String?
    public let location: String?
    public let url: URL
    
    public init(id: UUID, description: String?, location: String?, url: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.url = url
    }
}

extension FeedItem: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case description
        case location
        case url = "image"
    }
}
