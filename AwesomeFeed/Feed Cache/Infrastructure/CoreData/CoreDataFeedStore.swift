//
//  CoreDataFeedStore.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 6/6/21.
//

import CoreData

public class CoreDataFeedStore {
    private var container: NSPersistentContainer
    private let context: NSManagedObjectContext
    
    public init(storeURL: URL, bundle: Bundle = .main) throws {
        container = try NSPersistentContainer.load(modelName: "FeedStore", url: storeURL , in: bundle)
        context = container.newBackgroundContext()
    }
    
    func perform(_ action: @escaping (NSManagedObjectContext) -> Void) {
        let context = self.context
        context.perform {
            action(context)
        }
    }
    
}
