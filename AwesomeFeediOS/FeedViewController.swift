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
    private var tableModel: [FeedImage] = []
    
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
        loader?.load(completion: { [weak self] result in
            switch result {
            case let .success(feed):
                self?.refreshControl?.endRefreshing()
                self?.tableModel = feed
                self?.tableView.reloadData()
                
            case .failure: break
            }
            
        })
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = tableModel[indexPath.row]
        let cell = FeedImageCell()
        cell.locationContainer.isHidden = (cellModel.location == nil)
        cell.locationLabel.text = cellModel.location
        cell.descriptionLabel.text = cellModel.description
        return cell
    }
}
