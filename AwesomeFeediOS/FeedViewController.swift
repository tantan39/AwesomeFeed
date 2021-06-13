//
//  FeedViewController.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/12/21.
//

import UIKit
import AwesomeFeed

final public class FeedViewController: UITableViewController {
    private var loader: FeedLoader?
    
    public convenience init(loader: FeedLoader) {
        self.init()
        
        self.loader = loader
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        
        load()
    }
    
    @objc func load() {
        refreshControl?.beginRefreshing()
        loader?.load(completion: { [weak self] _ in
            self?.refreshControl?.endRefreshing()
        })
    }
}
