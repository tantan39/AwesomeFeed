//
//  FeedRefreshViewController.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/14/21.
//

import UIKit

final class FeedRefreshViewController: NSObject {
    lazy var view: UIRefreshControl = binding(UIRefreshControl())
    
    private let viewModel: FeedViewModel?
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }
        
    @objc func refresh() {
        viewModel?.loadFeed()
    }
    
    private func binding(_ view: UIRefreshControl) -> UIRefreshControl {
        viewModel?.onChange = { [weak self] viewModel in
            if viewModel.isLoading {
                self?.view.beginRefreshing()
            } else {
                self?.view.endRefreshing()
            }
        }
        
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
    
}
