//
//  HTTPClientTests.swift
//  AwesomeFeedTests
//
//  Created by Tan Tan on 5/28/21.
//

import XCTest

class URLSessionHTTPClient {
    private var session: URLSession
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL) {
        self.session.dataTask(with: url, completionHandler: { _, _, _ in
            
        }).resume()
    }
}

class URLSessionHTTPClientTests: XCTestCase {

    func test_getFromURL_resumeDataTaskWithURL() {
        let url = URL(string: "http://any-url.com")!
        let session = URLSessionSpy()
        let task = URLSessionDataTaskSpy()
        let sut = URLSessionHTTPClient(session: session)
        
        session.stub(url: url, task: task)
        sut.get(from: url)
        
        XCTAssertEqual(task.resumeCallCount, 1)
    }

    // MARK: - Helpers
    private class URLSessionSpy: URLSession {
        private var stubs: [URL: URLSessionDataTaskSpy] = [:]
        
        func stub(url: URL, task: URLSessionDataTaskSpy) {
            stubs[url] = task
        }
        
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            return stubs[url] ?? FakeURLSessionDataTask()
        }
    }
    
    private class FakeURLSessionDataTask: URLSessionDataTask {
        override func resume() { }
    }
    
    private class URLSessionDataTaskSpy: URLSessionDataTask {
        var resumeCallCount: Int = 0
        
        override func resume() {
            resumeCallCount += 1
        }
    }
}

