//
//  AlbumListTableViewCell.swift
//  AynchronousImageDownloadDemo
//
//  Created by Prajakta on 27/04/23.
//

import UIKit
import Combine
class AlbumListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumImgView: UIImageView!
    @IBOutlet weak var albumTitleLbl: UILabel!
    @IBOutlet weak var albumNumLbl: UILabel!
    
    var cancellables = Set<AnyCancellable>()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(album: AlbumModel) {
        
        self.albumNumLbl.text = String(album.id)
        self.albumTitleLbl.text = album.title
        
        //Using async-await
        Task  {
            self.albumImgView.image = await ImageDownloader().asyncImageDownloadUsingAsyncAwait(imageUrlString: album.thumbnailURL)
        }
        
        /*
        //Using Closure
        ImageDownloader().asyncImageDownloadUsingClosure(imageUrlString: album.thumbnailURL,
                                                         completionHandler: {[weak self] image in
            DispatchQueue.main.async {
                self?.albumImgView.image = image
            }
        })
        
        //Using Combine
        ImageDownloader().asyncImageDownloadUsingCombine(imageUrlString: album.thumbnailURL)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in
                
            }, receiveValue: {[weak self] image in
                self?.albumImgView.image = image
            })
            .store(in: &cancellables)
         */
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
