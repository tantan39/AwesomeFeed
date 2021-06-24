//
//  UITableView+Dequeueing.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/24/21.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
