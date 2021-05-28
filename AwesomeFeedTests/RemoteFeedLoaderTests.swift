//
//  RemoteFeedLoaderTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 5/27/21.
//

import XCTest
import AwesomeFeed

class RemoteFeedLoaderTests: XCTestCase {
    func test_init_withoutRequest() {
        let client = HTTPClientSpy()
        let _ = makeSUT()
        
        XCTAssertTrue(client.requestUrls.isEmpty)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-url.com")!
        let (sut, client) = makeSUT()
        sut.load(){ _ in }
        
        XCTAssertEqual(client.requestUrls, [url])
    }
    
    func test_loadTwice_requestDataFromURL_Twice() {
        let url = URL(string: "https://a-url.com")!
        let (sut, client) = makeSUT()
        
        sut.load(){ _ in }
        sut.load(){ _ in }
        
        XCTAssertEqual(client.requestUrls, [url, url])
    }
    
    func test_load_responseError() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(.connectionError)) {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        }

    }
    
    func test_load_responseErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()
        
        let sample = [199, 201, 300, 400, 500]
        sample.enumerated().forEach({ index, code in
            expect(sut, toCompleteWith: .failure(.invalidData)) {
                let json = makeJSONItems([])
                client.complete(withStatusCode: code, data: json, at: index )
            }
        })
    }
    
    func test_load_responseErrorOnNon200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .failure(.invalidData)) {
            let data = "invalid json data".data(using: .utf8)!
            client.complete(withStatusCode: 200, data: data )
        }
    }
    
    func test_load_responseNoItemWith200HTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: .success([])) {
            let emptyJSONList = Data("{\"items\": []}".utf8)
            client.complete(withStatusCode: 200, data: emptyJSONList)
        }
    }
    
    func test_load_deliversListItemOn200HTTPResponseWithJSONList() {
        let (sut, client) = makeSUT()
                
        let item1 = makeItem(id: UUID(), description: nil, location: nil, url: URL(string: "https://a-url.com")!)
        
        let item2 = makeItem(id: UUID(), description: "a description", location: "a location", url: URL(string: "https://a-url.com")!)
        
        let items = [item1.model, item2.model]
        
        expect(sut, toCompleteWith: .success(items)) {
            let json = makeJSONItems([item1.json, item2.json])
            client.complete(withStatusCode: 200, data: json)
        }
        
    }
    
    func test_load_doesNotDeliverReultAfterInstanceHasBeenDellocated() {
        let url = URL(string: "https://a-url.com")!
        let client = HTTPClientSpy()
        var sut: RemoteFeedLoader? = RemoteFeedLoader(url: url, client: client)
        
        var captureResults: [RemoteFeedLoader.Results] = []
        sut?.load(completion: { captureResults.append($0) })

        sut = nil
        client.complete(withStatusCode: 200, data: makeJSONItems([]))
        
        XCTAssertTrue(captureResults.isEmpty)

    }
    
    // MARK: - Helpers
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteFeedLoader, spy: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        trackMemoryLeaks(sut, file: file, line: line)
        trackMemoryLeaks(client, file: file, line: line)
        return (sut, client)
    }
    
    private func trackMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been dellocated. Potential memory leak", file: file, line: line)
        }
    }
    
    private func expect(_ sut: RemoteFeedLoader,
                        toCompleteWith result: RemoteFeedLoader.Results,
                        when action: () -> Void,
                        file: StaticString = #filePath, line: UInt = #line) {
        var captureResults: [RemoteFeedLoader.Results] = []
        sut.load(completion: { captureResults.append($0) })
        
        action()
        
        XCTAssertEqual(captureResults, [result], file: file, line: line)
    }
    
    private func makeItem(id: UUID, description: String? = nil, location: String? = nil, url: URL) -> (model: FeedItem, json: [String: Any])  {
        let item = FeedItem(id: id, description: description, location: location, url: url)
        let json = [ "id": item.id.description,
                          "description": item.description,
                          "location": item.location,
                          "image": item.url.absoluteString
        ]
        .reduce(into: [String: Any]()) { (acc, element) in
            if let value = element.value {
                acc[element.key] = value
            }
        }
        
        return (item, json)
    }
    
    private func makeJSONItems(_ items: [[String : Any]]) -> Data {
        let json = ["items": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    class HTTPClientSpy: HTTPClient {
        
        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
        
        var requestUrls: [URL] {
            return messages.map({ $0.url })
        }

        func get(url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }
        
        func complete(with error: Error, index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
            let response = HTTPURLResponse(url: requestUrls[index], statusCode: code, httpVersion: nil, headerFields: nil)!
            messages[index].completion(.success(data, response))
        }
    }
}
