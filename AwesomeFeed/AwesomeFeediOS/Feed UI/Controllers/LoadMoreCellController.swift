//
//  LoadMoreCellController.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 8/19/21.
//

import UIKit
import AwesomeFeed

public class LoadMoreCellController: NSObject, UITableViewDataSource {
    let cell = LoadMoreCell()
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cell
    }
}

extension LoadMoreCellController: ResourceLoadingView {
    public func display(_ viewModel: ResourceLoadingViewModel) {
        cell.isLoading = viewModel.isLoading
    }
}
