//
//  LoadImageCommentsFromRemoteUseCaseTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 8/4/21.
//

import XCTest
import AwesomeFeed

class LoadImageCommentsFromRemoteUseCaseTests: XCTestCase {

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
     
    func test_load_responseError() {
        let (sut, client) = makeSUT()
        
        expect(sut, toCompleteWith: failure(.connectionError)) {
            let clientError = NSError(domain: "Test", code: 0)
            client.completion(with: clientError)
        }

    }
    
    func test_load_responseErrorOnNon2xxHTTPResponse() {
        let (sut, client) = makeSUT()
        
        let sample = [199, 150, 300, 400, 500]
        sample.enumerated().forEach({ index, code in
            expect(sut, toCompleteWith: failure(.invalidData)) {
                let json = makeJSONItems([])
                client.complete(withStatusCode: code, data: json, at: index )
            }
        })
    }
    
    func test_load_responseErrorOnNon2xxHTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()
        
        let sample = [200, 201, 250, 280, 299]

        sample.enumerated().forEach({ index, code in
            expect(sut, toCompleteWith: failure(.invalidData)) {
                let data = "invalid json data".data(using: .utf8)!
                client.complete(withStatusCode: code, data: data, at: index )
            }
        })
    }
    
    func test_load_responseNoItemWith2xxHTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSUT()
        
        let sample = [200, 201, 250, 280, 299]
        
        sample.enumerated().forEach({ index, code in
            expect(sut, toCompleteWith: .success([])) {
                let emptyJSONList = makeJSONItems([])
                client.complete(withStatusCode: code, data: emptyJSONList, at: index)
            }
        })
    }
    
    func test_load_deliversListItemOn2xxHTTPResponseWithJSONList() {
        let (sut, client) = makeSUT()
                
        let item1 = makeItem(id: UUID(),
                             message: "a message",
                             createdAt: (Date(timeIntervalSince1970: 1598627222), "2020-08-28T15:07:02+00:00"),
                             username: "a username")
        
        let item2 = makeItem(id: UUID(),
                             message: "another message",
                             createdAt: (Date(timeIntervalSince1970: 1577881882), "2020-01-01T12:31:22+00:00"),
                             username: "another username")
        
        let items = [item1.model, item2.model]
        
        let sample = [200, 201, 250, 280, 299]
        
        sample.enumerated().forEach({ index, code in
            expect(sut, toCompleteWith: .success(items)) {
                let json = makeJSONItems([item1.json, item2.json])
                client.complete(withStatusCode: code, data: json, at: index)
            }
        })
        
    }
    
    func test_load_doesNotDeliverReultAfterInstanceHasBeenDellocated() {
        let url = URL(string: "https://a-url.com")!
        let client = HTTPClientSpy()
        var sut: RemoteImageCommentsLoader? = RemoteImageCommentsLoader(url: url, client: client)
        
        var captureResults: [RemoteImageCommentsLoader.Result] = []
        sut?.load(completion: { captureResults.append($0) })

        sut = nil
        client.complete(withStatusCode: 200, data: makeJSONItems([]))
        
        XCTAssertTrue(captureResults.isEmpty)

    }
    
    // MARK: - Helpers
    private func makeSUT(url: URL = URL(string: "https://a-url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteImageCommentsLoader, spy: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteImageCommentsLoader(url: url, client: client)
        trackMemoryLeaks(sut, file: file, line: line)
        trackMemoryLeaks(client, file: file, line: line)
        return (sut, client)
    }
    
    private func failure(_ error: RemoteImageCommentsLoader.Error) -> RemoteImageCommentsLoader.Result {
        return .failure(error)
    }
    
    private func expect(_ sut: RemoteImageCommentsLoader,
                        toCompleteWith expectedResult: RemoteImageCommentsLoader.Result,
                        when action: () -> Void,
                        file: StaticString = #filePath, line: UInt = #line) {
        
        let expect = expectation(description: "wait for load completion")
        
        sut.load(completion: { receiveResult in
            switch (receiveResult, expectedResult) {
            case let (.success(receiveItems), .success(expectedItems)):
                XCTAssertEqual(receiveItems, expectedItems, file: file, line: line)
                
            case let (.failure(receiveError as RemoteImageCommentsLoader.Error), .failure(expectedError as RemoteImageCommentsLoader.Error)):
                XCTAssertEqual(receiveError, expectedError, file: file, line: line)
                
            default:
                XCTFail("Expected result \(expectedResult) got \(receiveResult) instead", file: file, line: line)
            }
            expect.fulfill()
        })
        
        action()
        wait(for: [expect], timeout: 1)
    }
    
    private func makeItem(id: UUID, message: String, createdAt: (date: Date, iso8601String: String), username: String) -> (model: ImageComment, json: [String: Any])  {
        let item = ImageComment(id: id, message: message, createdAt: createdAt.date, username: username)
        
        let json: [String: Any] = [ "id": id.uuidString,
                          "message": message,
                          "created_at": createdAt.iso8601String,
                          "author": [
                            "username": username
                          ]
        ]
        
        return (item, json)
    }
    
    private func makeJSONItems(_ items: [[String : Any]]) -> Data {
        let json = ["items": items]
        return try! JSONSerialization.data(withJSONObject: json)
    }


}
