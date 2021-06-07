//
//  ManagedFeedImage.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 6/7/21.
//

import CoreData

@objc(ManagedFeedImage)
internal class ManagedFeedImage: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var imageDescription: String?
    @NSManaged var location: String?
    @NSManaged var url: URL
    @NSManaged var cache: ManagedCache
}

extension ManagedFeedImage {
    static func images(from feed: [LocalFeedImage], in context: NSManagedObjectContext) -> NSOrderedSet {
        return NSOrderedSet(array: feed.map({ local in
            let manageFeedImage = ManagedFeedImage(context: context)
            manageFeedImage.id = local.id
            manageFeedImage.imageDescription = local.description
            manageFeedImage.location = local.location
            manageFeedImage.url = local.url
            return manageFeedImage
        }))
    }
    
    var local: LocalFeedImage {
        return LocalFeedImage(id: id, description: imageDescription, location: location, url: url)
    }
    
}
