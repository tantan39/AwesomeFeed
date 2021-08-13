//
//  ImageCommentCellController.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 8/12/21.
//

import UIKit
import AwesomeFeed

public class ImageCommentCellController: NSObject, CellController {
    private let model: ImageCommentViewModel
    
    public init(model: ImageCommentViewModel) {
        self.model = model
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ImageCommentCell = tableView.dequeueReusableCell()
        cell.messageLabel.text = self.model.message
        cell.usernameLabel.text = self.model.username
        cell.dateLabel.text = self.model.date
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
}
