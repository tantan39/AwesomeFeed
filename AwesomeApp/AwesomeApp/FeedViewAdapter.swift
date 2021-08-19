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
    private let selection: (FeedImage) -> Void
    
    public typealias ImageDataPresentationAdapter = LoadResourcePresentationAdapter<Data, WeakRefVirtualProxy<FeedImageCellController>>
    
    init(controller: ListViewController, imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher, selection: @escaping (FeedImage) -> Void) {
        self.controller = controller
        self.imageLoader = imageLoader
        self.selection = selection
    }
    
    func display(_ viewModel: Paginated<FeedImage>) {
        self.controller?.display(viewModel.items.map { model in
            let adapter = ImageDataPresentationAdapter (loader: { [imageLoader] in
                imageLoader(model.url)
            })
            
            let view = FeedImageCellController(
                viewModel: FeedImagePresenter.map(model),
                delegate: adapter,
                selection: { [selection] in
                    selection(model) })
            
            adapter.presenter = LoadResourcePresenter(
                resourceView: WeakRefVirtualProxy(view),
                loadingView: WeakRefVirtualProxy(view),
                errorView: WeakRefVirtualProxy(view),
                mapper: UIImage.tryMake)
            
            return CellController(id: model, view)
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

