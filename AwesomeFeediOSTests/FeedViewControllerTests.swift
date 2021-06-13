//
//  FeedViewControllerTests.swift
//  AwesomeFeediOSTests
//
//  Created by Tan Tan on 6/12/21.
//

import XCTest
import UIKit
import AwesomeFeed

final class FeedViewController: UIViewController {
    private var loader: FeedLoader?
    
    convenience init(loader: FeedLoader) {
        self.init()
        
        self.loader = loader
    }
    
    override func viewDidLoad() {
        loader?.load(completion: { _ in })
    }
}

final class FeedViewControllerTests: XCTestCase {
    
    func test_init_doesNotLoadFeed() {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)

        XCTAssertEqual(loader.loadCallCount, 0)

    }
    
    func test_viewDidload_loadsFeed() {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        
        sut.loadViewIfNeeded()

        XCTAssertEqual(loader.loadCallCount, 1)
    }
    
    // MARK: - Helpers
    class LoaderSpy: FeedLoader {
        private(set) var loadCallCount: Int = 0
        
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            loadCallCount += 1
        }
    }
}
