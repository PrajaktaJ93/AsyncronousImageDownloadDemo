//
//  AlbumModel.swift
//  AynchronousImageDownloadDemo
//
//  Created by Prajakta on 27/04/23.
//

import Foundation

struct AlbumModel: Codable {
    let albumID, id: Int
    let title, url, thumbnailURL: String
    
    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
