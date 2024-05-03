//
//  AynchronousImageDownloadDemoTests.swift
//  AynchronousImageDownloadDemoTests
//
//  Created by Prajakta on 27/04/23.
//

import XCTest
@testable import AynchronousImageDownloadDemo

class AynchronousImageDownloadDemoTests: XCTestCase {

    var sut: AlbumViewModel!
        
    let mockArr = [AlbumModel(albumID: 1, id: 1, title: "title", url: "url", thumbnailURL: "thumbnailURL")]
    let mockUrl = "testURL"

    override func setUp() {
        super.setUp()
        sut = AlbumViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_AlbumListAPICalled_AlbumsNotZero() {
       
        sut.callAlbumListAPI(urlString: mockUrl, completionBlock: {
            XCTAssert(true, "Album List API Success")
            var isArrayEmpty = true
            if self.mockArr.count > 0 {
                isArrayEmpty = false
            }
            XCTAssert(isArrayEmpty, "Album List is not empty")
        })
    }
}

