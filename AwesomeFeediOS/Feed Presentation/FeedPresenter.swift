//
//  FeedPresenter.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/21/21.
//

import AwesomeFeed
protocol FeedView {
    func display(_ viewModel: FeedViewModel)
}

protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

final class FeedPresenter {
    private let feedView: FeedView
    private let loadingView: FeedLoadingView
    
    static var title: String {
        return NSLocalizedString("FEED_VIEW_TITLE", tableName: "Feed", bundle: Bundle(for: FeedPresenter.self), comment: "Title for the feed view")
    }
    
    init(feedView: FeedView, loadingView: FeedLoadingView) {
        self.feedView = feedView
        self.loadingView = loadingView
    }
    
    func didStartLoadingFeed() {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async { [weak self] in
                self?.didStartLoadingFeed()
            }
        }
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    func didFinishLoadingFeed(with feed: [FeedImage]) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async { [weak self] in
                self?.didFinishLoadingFeed(with: feed)
            }
        }
        feedView.display(FeedViewModel(feed: feed))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    func didFinishLoadingFeed(with error: Error) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async { [weak self] in
                self?.didFinishLoadingFeed(with: error)
            }
        }
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }

}
