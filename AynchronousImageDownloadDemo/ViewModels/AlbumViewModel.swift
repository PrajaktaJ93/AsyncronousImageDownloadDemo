//
//  AlbumViewModel.swift
//  AynchronousImageDownloadDemo
//
//  Created by Prajakta on 27/04/23.
//

import Foundation

protocol AlbumViewModelProtocol {
    func callAlbumListAPI(urlString: String, completionBlock: @escaping () -> Void)
}

class AlbumViewModel: AlbumViewModelProtocol {
    
    var arrAlbum = [AlbumModel]()
    func callAlbumListAPI(urlString: String, completionBlock: @escaping () -> Void) {
        NetworkUtility.shared.callAPI(urlString: urlString, completionBlock: { [weak self] (model: [AlbumModel]?) in
            if let model = model{
                self?.arrAlbum = model
                completionBlock()
            }
        })
    }
}
