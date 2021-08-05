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

public func anyData() -> Data {
    return Data("any data".utf8)
}

public func makeJSONItems(_ items: [[String : Any]]) -> Data {
    let json = ["items": items]
    return try! JSONSerialization.data(withJSONObject: json)
}

public extension HTTPURLResponse {
    convenience init(statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
