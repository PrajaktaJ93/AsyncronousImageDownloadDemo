//
//  AlbumListTableViewCell.swift
//  AynchronousImageDownloadDemo
//
//  Created by Prajakta on 27/04/23.
//

import UIKit

class AlbumListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var albumImgView: UIImageView!
    @IBOutlet weak var albumTitleLbl: UILabel!
    @IBOutlet weak var albumNumLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUpCell(album: AlbumModel) {
        
        self.albumNumLbl.text = String(album.id)
        self.albumTitleLbl.text = album.title
        Task  {
            self.albumImgView.image = await ImageDownloader().asyncImageDownload(imageUrlString: album.thumbnailURL)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
