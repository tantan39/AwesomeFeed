//
//  RemoteLoaderTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 8/4/21.
//

import XCTest
import AwesomeFeed

class RemoteLoaderTests: XCTestCase {
    func test_init_withoutRequest() {
        let client = HTTPClientSpy()
        let _ = makeSUT()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestDataFromURL() {
        let url = URL(string: "https://a-url.com")!
        let (sut, client) = makeSUT()
        sut.load(){ _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestDataFromURL_Twice() {
        let url = URL(string: "https://a-url.com")!
        let (sut, client) = makeSUT()
        
        sut.load(){ _ in }
        sut.load(){ _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
     
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: failure(.connectionError)) {
            let clientError = NSError(domain: "Test", code: 0)
            client.completion(with: clientError)
        }

    }
    
    func test_load_deliversErrorOnMapperError() {
        let (sut, client) = makeSUT(mapper: { _, _ in
            throw anyError()
        })
        
        expect(sut, toCompleteWith: failure(.invalidData)) {
            client.complete(withStatusCode: 200, data: anyData() )
        }
    }
    
    func test_load_deliversMappedResource() {
        let resource = "a resource"
        
        let (sut, client) = makeSUT(mapper: { data, _ in
            String(data: data, encoding: .utf8)!
        })
                        
        expect(sut, toCompleteWith: .success(resource)) {
            client.complete(withStatusCode: 200, data: Data(resource.utf8))
        }
        
    }
    
    func test_load_doesNotDeliverReultAfterInstanceHasBeenDellocated() {
        let url = URL(string: "https://a-url.com")!
        let client = HTTPClientSpy()
        var sut: RemoteLoader<String>? = RemoteLoader<String>(url: url, client: client, mapper: { _, _ in "any"})
        
        var captureResults: [RemoteLoader<String>.Result] = []
        sut?.load(completion: { captureResults.append($0) })

        sut = nil
        client.complete(withStatusCode: 200, data: makeJSONItems([]))
        
        XCTAssertTrue(captureResults.isEmpty)

    }
    
    // MARK: - Helpers
    
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!,
                         mapper: @escaping RemoteLoader<String>.Mapper = { _, _ in "any" },
                         file: StaticString = #filePath,
                         line: UInt = #line) -> (sut: RemoteLoader<String>, spy: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteLoader<String>(url: url, client: client, mapper: mapper)
        trackMemoryLeaks(sut, file: file, line: line)
        trackMemoryLeaks(client, file: file, line: line)
        return (sut, client)
    }
    
    private func failure(_ error: RemoteLoader<String>.Error) -> RemoteLoader<String>.Result {
        return .failure(error)
    }
    
    private func expect(_ sut: RemoteLoader<String>,
                        toCompleteWith expectedResult: RemoteLoader<String>.Result,
                        when action: () -> Void,
                        file: StaticString = #filePath, line: UInt = #line) {
        
        let expect = expectation(description: "wait for load completion")
        
        sut.load(completion: { receiveResult in
            switch (receiveResult, expectedResult) {
            case let (.success(receiveItems), .success(expectedItems)):
                XCTAssertEqual(receiveItems, expectedItems, file: file, line: line)
                
            case let (.failure(receiveError as RemoteLoader<String>.Error), .failure(expectedError as RemoteLoader<String>.Error)):
                XCTAssertEqual(receiveError, expectedError, file: file, line: line)
                
            default:
                XCTFail("Expected result \(expectedResult) got \(receiveResult) instead", file: file, line: line)
            }
            expect.fulfill()
        })
        
        action()
        wait(for: [expect], timeout: 1)
    }
    
    private func makeItem(id: UUID, description: String? = nil, location: String? = nil, url: URL) -> (model: FeedImage, json: [String: Any])  {
        let item = FeedImage(id: id, description: description, location: location, url: url)
        let json = [ "id": item.id.description,
                          "description": item.description,
                          "location": item.location,
                          "image": item.url.absoluteString
        ]
        .compactMapValues({ $0 })
        
        return (item, json)
    }
    
    private func makeJSONItems(_ items: [[String : Any]]) -> Data {
        let json = ["items": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }
}
