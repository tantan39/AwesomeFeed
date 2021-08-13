//
//  FeedViewController.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/12/21.
//

import UIKit
import AwesomeFeed

public protocol CellController {
    func view(in tableView: UITableView) -> UITableViewCell
    func preload()
    func cancelLoad()
}

final public class ListViewController: UITableViewController, UITableViewDataSourcePrefetching, ResourceLoadingView, ResourceErrorView {
    
    public var onRefresh: (() -> Void)?
    
    @IBOutlet private(set) public var errorView: ErrorView?
    
    private var loadingItems = [IndexPath: CellController]()

    private var tableModel = [CellController]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.sizeTableHeaderToFit()
    }
    
    @IBAction private func refresh() {
        self.onRefresh?()
    }
    
    public func display(_ cellControllers: [CellController]) {
        tableModel = cellControllers
        loadingItems = [:]
    }
    
    public func display(_  viewModel: ResourceLoadingViewModel) {
        self.refreshControl?.update(isRefreshing: viewModel.isLoading)
    }
    
    public func display(_ viewModel: ResourceErrorViewModel) {
        errorView?.message = viewModel.message
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellController = cellController(forRowAt: indexPath)
        return cellController.view(in: tableView)
    }
    
    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelCellControllerLoad(forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            let cellController = cellController(forRowAt: indexPath)
            cellController.preload()
        }
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(cancelCellControllerLoad)
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> CellController {
        let model = tableModel[indexPath.row]
        loadingItems[indexPath] = model
        return model
    }
    
    private func cancelCellControllerLoad(forRowAt indexPath: IndexPath) {
        loadingItems[indexPath]?.cancelLoad()
        loadingItems[indexPath] = nil
    }
    
}
