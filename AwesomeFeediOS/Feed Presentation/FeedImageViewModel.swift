//
//  FeedImageViewModel.swift
//  AwesomeFeediOS
//
//  Created by Tan Tan on 6/21/21.
//

import AwesomeFeed

final class FeedImageViewModel<Image> {
    typealias Observer<T> = ( (T) -> Void)
    
    private var task: FeedImageDataLoaderTask?
    private let model: FeedImage
    private let imageLoader: FeedImageDataLoader
    
    private var imageTransformer: ((Data) -> Image?)
    
    init(model: FeedImage, imageLoader: FeedImageDataLoader, imageTransformer: @escaping ((Data) -> Image?)) {
        self.model = model
        self.imageLoader = imageLoader
        self.imageTransformer = imageTransformer
    }
    
    var location: String? {
        return model.location
    }
    
    var description: String? {
        return model.description
    }
    
    var hasLocation: Bool {
        return location != nil
    }
    
    var onImageLoad: Observer<Image>?
    var onImageLoadingStateChange: Observer<Bool>?
    var onShouldRetryImageLoadStateChange: Observer<Bool>?
    
    func loadImageData() {
        onImageLoadingStateChange?(true)
        onShouldRetryImageLoadStateChange?(false)
        
        task = imageLoader.loadImageData(from: model.url) { [weak self] result in
            self?.handle(result)
        }
        
    }
    
    private func handle(_ result: FeedImageDataLoader.Result) {
        if let image = (try? result.get()).flatMap(self.imageTransformer) {
            onImageLoad?(image)
        } else {
            onShouldRetryImageLoadStateChange?(true)
        }
        onImageLoadingStateChange?(false)
    }
    
    func cancelImageDataLoad() {
        task?.cancel()
        task = nil
    }
}
