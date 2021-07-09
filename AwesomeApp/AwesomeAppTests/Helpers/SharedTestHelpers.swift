//
//  SharedTestHelpers.swift
//  AwesomeAppTests
//
//  Created by Tan Tan on 7/9/21.
//

import Foundation

func anyURL() -> URL {
    return URL(string: "http://a-url.com")!
}

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyData() -> Data {
    return Data("any data".utf8)
}

