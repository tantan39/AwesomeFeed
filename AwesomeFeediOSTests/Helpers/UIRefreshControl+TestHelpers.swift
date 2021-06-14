//
//  UIRefreshControl+TestHelpers.swift
//  AwesomeFeediOSTests
//
//  Created by Tan Tan on 6/14/21.
//

import UIKit

 extension UIRefreshControl {
     func simulatePullToRefresh() {
         allTargets.forEach { target in
             actions(forTarget: target, forControlEvent: .valueChanged)?.forEach {
                 (target as NSObject).perform(Selector($0))
             }
         }
     }
 }
