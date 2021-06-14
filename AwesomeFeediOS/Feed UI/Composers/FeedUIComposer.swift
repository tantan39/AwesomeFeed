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
         let refreshController = FeedRefreshViewController(feedLoader: feedLoader)
         let feedController = FeedViewController(refreshController: refreshController)
         refreshController.onRefresh = { [weak feedController] feed in
             feedController?.tableModel = feed.map { model in
                 FeedImageCellController(model: model, imageLoader: imageLoader)
             }
         }
         return feedController
     }

 }
