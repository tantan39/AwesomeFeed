//
//  ImageCommentCellController.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 8/12/21.
//

import UIKit
import AwesomeFeed

public class ImageCommentCellController: CellController {
    private let model: ImageCommentViewModel
    
    public init(model: ImageCommentViewModel) {
        self.model = model
    }
    
    public func view(in tableView: UITableView) -> UITableViewCell {
        let cell: ImageCommentCell = tableView.dequeueReusableCell()
        cell.messageLabel.text = self.model.message
        cell.usernameLabel.text = self.model.username
        cell.dateLabel.text = self.model.date
        
        return cell
    }
    
    public func preload() {
        
    }
    
    public func cancelLoad() {
        
    }
    
    
}
