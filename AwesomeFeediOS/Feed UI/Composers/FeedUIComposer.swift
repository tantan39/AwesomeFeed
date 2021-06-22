//
//  FeedUIComposer.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/14/21.
//

import UIKit
import AwesomeFeed

public final class FeedUIComposer {
     private init() {}

     public static func feedComposedWith(feedLoader: FeedLoader, imageLoader: FeedImageDataLoader) -> FeedViewController {
        let presenter = FeedPresenter(feedLoader: feedLoader)
        let refreshController = FeedRefreshViewController(presenter: presenter)
        let feedController = FeedViewController(refreshController: refreshController)
        presenter.loadingView = WeakRefVirtualProxy(object: refreshController)
        presenter.feedView = FeedViewAdapter(controller: feedController, loader: imageLoader)

        return feedController
     }

    private static func adaptFeedToCellControllers(forwardingTo controller: FeedViewController, loader: FeedImageDataLoader) -> ([FeedImage]) -> Void {
        return { [weak controller] feed in
            controller?.tableModel = feed.map { model in
                return FeedImageCellController(viewModel: FeedImageViewModel(model: model, imageLoader: loader, imageTransformer: UIImage.init))
            }
        }
    }
 }

final class WeakRefVirtualProxy<T: AnyObject> {
    private weak var object: T?
    
    init(object: T) {
        self.object = object
    }
}

extension WeakRefVirtualProxy: FeedLoadingView where T: FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel) {
        object?.display(FeedLoadingViewModel(isLoading: viewModel.isLoading))
        
    }
}

public class FeedViewAdapter: FeedView {
    private weak var controller: FeedViewController?
    private let loader: FeedImageDataLoader
    
    init(controller: FeedViewController, loader: FeedImageDataLoader) {
        self.controller = controller
        self.loader = loader
    }
    
    func display(_ viewModel: FeedViewModel) {
        self.controller?.tableModel = viewModel.feed.map { model in
            FeedImageCellController(viewModel:
                                        FeedImageViewModel(model: model,
                                                           imageLoader: loader,
                                                           imageTransformer: UIImage.init))
        }
    }
    
}
