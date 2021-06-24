//
//  UIImageView+Animations.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/24/21.
//

import UIKit

extension UIImageView {
    func setImageAnimated(_ newImage: UIImage?) {
        image = newImage
        guard newImage != nil else { return }
        
        alpha = 0
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1
        }
    }
}
