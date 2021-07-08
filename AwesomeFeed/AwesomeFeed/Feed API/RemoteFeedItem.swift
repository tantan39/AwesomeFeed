//
//  RemoteFeedItem.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 6/1/21.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
