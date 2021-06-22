//
//  FeedRefreshViewController.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/14/21.
//

import UIKit

final class FeedRefreshViewController: NSObject, FeedLoadingView {
    lazy var view: UIRefreshControl = loadView()
    
    private let presenter: FeedPresenter
    
    init(presenter: FeedPresenter) {
        self.presenter = presenter
    }
        
    @objc func refresh() {
        presenter.loadFeed()
    }
    
    func display(isLoading: Bool) {
        if isLoading {
            self.view.beginRefreshing()
        } else {
            self.view.endRefreshing()
        }
    }
    
    private func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
    
}
