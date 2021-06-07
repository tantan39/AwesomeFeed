//
//  AwesomeFeedCacheIntegrationTests.swift
//  AwesomeFeedCacheIntegrationTests
//
//  Created by Tan Tan on 6/7/21.
//

import XCTest
import AwesomeFeed

class AwesomeFeedCacheIntegrationTests: XCTestCase {

    func test_load_deliversNoItemsOnEmptyCache() {
        let sut = makeSUT()
        
        let exp = expectation(description: "Wait for load completion")
        sut.load { result in
            switch result {
            case let .success(feed):
                XCTAssertEqual(feed, [], "Expected empty feed")
                
            case let .failure(error):
                XCTFail("Expected successful feed result, got \(error) instead")
            }
            
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
        
    }
    
    func test_load_deliversItemsSaveOnASeparateInstance() {
        let sutToPerformSave = makeSUT()
        let sutToPerformLoad = makeSUT()
        let saveExp = expectation(description: "Wait for save completion")
        let feed = uniqueImageFeed().models
        
        sutToPerformSave.save(feed, completion: { saveError in
            XCTAssertNil(saveError, "Expected to save feed successfully")
            saveExp.fulfill()
        })
        wait(for: [saveExp], timeout: 1.0)
        
        let loadExp = expectation(description: "Wait for load completion")
        sutToPerformLoad.load(completion: { result in
            switch result {
            case let .success(imageFeed):
                XCTAssertEqual(imageFeed, feed)
                
            case let .failure(error):
                XCTFail("Expected successful feed result, got \(error) instead")
            }
            loadExp.fulfill()
        })
        wait(for: [loadExp], timeout: 1.0)
        
    }
    
    // MARK: - Helpers
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> LocalFeedLoader {
        let storeBundle = Bundle(for: CoreDataFeedStore.self)
        let storeURL = testSpecificStoreURL()
        let store = try! CoreDataFeedStore(storeURL: storeURL, bundle: storeBundle)
        let sut = LocalFeedLoader(store: store, currentDate: Date.init)
        trackMemoryLeaks(store, file: file, line: line)
        trackMemoryLeaks(sut, file: file, line: line)
        return sut
     }
    
    private func testSpecificStoreURL() -> URL {
        return cachesDirectory().appendingPathComponent("\(type(of: self)).store")
    }
    
    private func cachesDirectory() -> URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
}
