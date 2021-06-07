//
//  CoreDataFeedStore.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 6/6/21.
//

import CoreData

public class CoreDataFeedStore: FeedStore {
    private var container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    public init(storeURL: URL, bundle: Bundle = .main) throws {
        container = try NSPersistentContainer.load(modelName: "FeedStore", url: storeURL , in: bundle)
        context = container.newBackgroundContext()
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        let context = self.context
        context.perform {
            do {
                let request = NSFetchRequest<ManageCache>(entityName: ManageCache.entity().name!)
                request.returnsObjectsAsFaults = false
                if let cache = try context.fetch(request).first {
                    let feed = cache.feed
                        .compactMap({ $0 as? ManageFeedImage})
                        .map({
                        LocalFeedImage(id: $0.id, description: $0.imageDescription, location: $0.location, url: $0.url)
                    })
                    
                    completion(.found(feed: feed, timestamp: cache.timestamp))
                    
                } else {
                    completion(.empty)
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        let context = self.context
        context.perform {
            do {
                let manageCache = ManageCache(context: context)
                manageCache.timestamp = timestamp
                manageCache.feed = NSOrderedSet(array: feed.map({ local in
                    let manageFeedImage = ManageFeedImage(context: context)
                    manageFeedImage.id = local.id
                    manageFeedImage.imageDescription = local.description
                    manageFeedImage.location = local.location
                    manageFeedImage.url = local.url
                    return manageFeedImage
                }))
                
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
            
        }
        
    }
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        
    }
    
}

private extension NSPersistentContainer {
    enum LoadingError: Swift.Error {
        case modelNotFound
        case failedToLoadPersistentStores(Swift.Error)
    }
    
    static func load(modelName name: String, url: URL, in bundle: Bundle) throws -> NSPersistentContainer {
        guard let model = NSManagedObjectModel.with(name: name, in: bundle) else { throw LoadingError.modelNotFound }
        
        let description = NSPersistentStoreDescription(url: url)
        let container = NSPersistentContainer(name: name, managedObjectModel: model)
        container.persistentStoreDescriptions = [description]
        
        var loadError: Swift.Error?
        container.loadPersistentStores(completionHandler: { loadError = $1 })
        try loadError.map { throw LoadingError.failedToLoadPersistentStores($0) }
        
        return container
    }
}

private extension NSManagedObjectModel {
    static func with(name: String, in bundle: Bundle) -> NSManagedObjectModel? {
        return bundle.url(forResource: name, withExtension: "momd")
            .flatMap({ NSManagedObjectModel(contentsOf: $0) })
    }
}

@objc(ManageCache)
private class ManageCache: NSManagedObject {
    @NSManaged var timestamp: Date
    @NSManaged var feed: NSOrderedSet
}

@objc(ManageFeedImage)
private class ManageFeedImage: NSManagedObject {
    @NSManaged var id: UUID
    @NSManaged var imageDescription: String?
    @NSManaged var location: String?
    @NSManaged var url: URL
    @NSManaged var cache: ManageCache
}
