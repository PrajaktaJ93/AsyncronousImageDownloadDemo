//
//  AynchronousImageDownloadDemoTests.swift
//  AynchronousImageDownloadDemoTests
//
//  Created by Prajakta on 27/04/23.
//

import XCTest
@testable import AynchronousImageDownloadDemo

class AynchronousImageDownloadDemoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_AlbumListAPICalled_AlbumsNotZero() throws {
       let sut = AlbumViewModel()
        let arr = sut.arrAlbum
        let mockUrl = "testURL"
        sut.callAlbumListAPI(urlString: mockUrl, completionBlock: {
            XCTAssertTrue(arr.count > 0)
        })
    }
    
}
