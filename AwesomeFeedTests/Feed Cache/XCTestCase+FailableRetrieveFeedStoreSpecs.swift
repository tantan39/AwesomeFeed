//
//  XCTestCase+FailableRetrieveFeedStoreSpecs.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 6/6/21.
//

import XCTest
import AwesomeFeed

 extension FailableRetrieveFeedStoreSpecs where Self: XCTestCase {
     func assertThatRetrieveDeliversFailureOnRetrievalError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         expect(sut, toRetrieve: .failure(anyError()), file: file, line: line)
     }

     func assertThatRetrieveHasNoSideEffectsOnFailure(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         expect(sut, toRetrieveTwice: .failure(anyError()), file: file, line: line)
     }
 }
