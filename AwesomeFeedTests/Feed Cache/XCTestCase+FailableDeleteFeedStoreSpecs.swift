//
//  XCTestCase+FailableDeleteFeedStoreSpecs.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 6/6/21.
//

import XCTest
import AwesomeFeed

 extension FailableDeleteFeedStoreSpecs where Self: XCTestCase {
     func assertThatDeleteDeliversErrorOnDeletionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         let deletionError = deleteCache(from: sut)

         XCTAssertNotNil(deletionError, "Expected cache deletion to fail", file: file, line: line)
     }

     func assertThatDeleteHasNoSideEffectsOnDeletionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         deleteCache(from: sut)

         expect(sut, toRetrieve: .empty, file: file, line: line)
     }
 }
