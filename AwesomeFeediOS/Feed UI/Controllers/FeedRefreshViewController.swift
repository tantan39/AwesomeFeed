//
//  FeedRefreshViewController.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/14/21.
//

import UIKit

protocol FeedRefreshViewControllerDelegate {
    func didRequestFeedRefresh()
}

final class FeedRefreshViewController: NSObject, FeedLoadingView {
    @IBOutlet private var view: UIRefreshControl?
    
    var delegate: FeedRefreshViewControllerDelegate?
        
    @IBAction func refresh() {
        delegate?.didRequestFeedRefresh()
    }
    
    func display(_  viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            self.view?.beginRefreshing()
        } else {
            self.view?.endRefreshing()
        }
    }
    
}
