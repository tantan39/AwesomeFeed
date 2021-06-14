//
//  UIRefreshControl+TestHelpers.swift
//  AwesomeFeediOSTests
//
//  Created by Tan Tan on 6/14/21.
//

import UIKit

 extension UIRefreshControl {
     func simulatePullToRefresh() {
        simulate(event: .valueChanged)
     }
 }
