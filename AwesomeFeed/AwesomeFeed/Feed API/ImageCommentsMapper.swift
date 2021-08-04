//
//  ImageCommentsMapper.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 8/4/21.
//

import Foundation

internal final class ImageCommentsMapper {

    private struct Root: Decodable {
        let items: [RemoteFeedItem]
    }
    
    internal static func map(_ data: Data, response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
             throw RemoteImageCommentsLoader.Error.invalidData
        }
        
        return root.items
    }
}
