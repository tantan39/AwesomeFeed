//
//  UIControl+TestHelpers.swift
//  AwesomeFeediOSTests
//
//  Created by Tan Tan on 6/14/21.
//

import UIKit

 extension UIControl {
     func simulate(event: UIControl.Event) {
         allTargets.forEach { target in
             actions(forTarget: target, forControlEvent: event)?.forEach {
                 (target as NSObject).perform(Selector($0))
             }
         }
     }
 }
