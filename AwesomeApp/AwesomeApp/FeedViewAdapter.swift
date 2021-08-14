//
//  FeedViewAdapter.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/24/21.
//

import UIKit
import AwesomeFeed
import AwesomeFeediOS

final class FeedViewAdapter: ResourceView {
    private weak var controller: ListViewController?
    private let imageLoader: (URL) -> FeedImageDataLoader.Publisher
    
    public typealias ImageDataPresentationAdapter = LoadResourcePresentationAdapter<Data, WeakRefVirtualProxy<FeedImageCellController>>
    
    init(controller: ListViewController, imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher) {
        self.controller = controller
        self.imageLoader = imageLoader
    }
    
    func display(_ viewModel: FeedViewModel) {
        self.controller?.display(viewModel.feed.map { model in
            let adapter = ImageDataPresentationAdapter (loader: { [imageLoader] in
                imageLoader(model.url)
            })
            
            let view = FeedImageCellController(viewModel: FeedImagePresenter.map(model), delegate: adapter)
            
            adapter.presenter = LoadResourcePresenter(
                resourceView: WeakRefVirtualProxy(view),
                loadingView: WeakRefVirtualProxy(view),
                errorView: WeakRefVirtualProxy(view),
                mapper: UIImage.tryMake)
            
            return CellController(view)
        })
    }
    
}

extension UIImage {
    struct InvalidImageData: Error {}
    
    static func tryMake(_ data: Data) throws -> UIImage {
        if let image = UIImage(data: data) {
            return image
        }
        
        throw InvalidImageData()
    }
}

