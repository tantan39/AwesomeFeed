//
//  HTTPURLResponse+StatusCode.swift
//  AwesomeFeed
//
//  Created by Tan Tan on 7/1/21.
//

import Foundation

extension HTTPURLResponse {
    public static var OK_200: Int {
        return 200
    }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
