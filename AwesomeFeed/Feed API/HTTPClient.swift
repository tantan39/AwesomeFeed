//
//  HTTPClient.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 5/28/21.
//

import Foundation
public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}

public protocol HTTPClient {
    func get(url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
