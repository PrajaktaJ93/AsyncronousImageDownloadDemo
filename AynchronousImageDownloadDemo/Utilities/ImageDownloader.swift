//
//  ImageDownloader.swift
//  AynchronousImageDownloadDemo
//
//  Created by Prajakta on 28/04/23.
//

import Foundation
import UIKit

class ImageDownloader {
    
    let session = NetworkUtility.shared.session
    
    /// Generic function to download image.

    func asyncImageDownload(imageUrlString: String) async -> UIImage? {
        let imageUrl = URL(string: imageUrlString)!
        do {
            let (imageData, _) =  try await session.data(from: imageUrl, delegate: nil)
            let image = UIImage(data: imageData as Data)
            return image ?? UIImage()
        } catch {
            return nil
        }
    }
}
