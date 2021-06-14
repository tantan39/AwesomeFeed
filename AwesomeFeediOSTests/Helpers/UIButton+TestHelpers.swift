//
//  UIButton+TestHelpers.swift
//  AwesomeFeediOSTests
//
//  Created by Tan Tan on 6/14/21.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
