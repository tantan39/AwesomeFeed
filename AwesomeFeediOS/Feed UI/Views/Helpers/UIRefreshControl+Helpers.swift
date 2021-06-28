//
//  UIRefreshControl+Helpers.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/28/21.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
