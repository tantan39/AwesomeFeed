//
//  XCTestCase+FailableInsertFeedStoreSpecs.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 6/6/21.
//

import XCTest
import AwesomeFeed

 extension FailableInsertFeedStoreSpecs where Self: XCTestCase {
     func assertThatInsertDeliversErrorOnInsertionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         let insertionError = insert((uniqueImageFeed().local, Date()), to: sut)

         XCTAssertNotNil(insertionError, "Expected cache insertion to fail with an error", file: file, line: line)
     }

     func assertThatInsertHasNoSideEffectsOnInsertionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         insert((uniqueImageFeed().local, Date()), to: sut)

         expect(sut, toRetrieve: .empty, file: file, line: line)
     }
 }
