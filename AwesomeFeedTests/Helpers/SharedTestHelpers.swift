//
//  SharedTestHelper.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 6/2/21.
//

import Foundation

public func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

public func anyError() -> NSError {
    return NSError(domain: "any error", code: 0)
}
