//
//  ImageDownloader.swift
//  AynchronousImageDownloadDemo
//
//  Created by Prajakta on 28/04/23.
//

import Foundation
import UIKit
import Combine
class ImageDownloader {
    
    let session = NetworkUtility.shared.session
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data = data,
              let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            return UIImage()
        }
        return image
    }
    
    //Function to download image using async-await.
    
    func asyncImageDownloadUsingAsyncAwait(imageUrlString: String) async -> UIImage? {
        let imageUrl = URL(string: imageUrlString)!
        do {
            let (imageData, _) =  try await session.data(from: imageUrl, delegate: nil)
            let image = UIImage(data: imageData as Data)
            return image ?? UIImage()
        } catch {
            return nil
        }
    }
    
    //Function to download image using Closure.
    
    func asyncImageDownloadUsingClosure(imageUrlString: String, completionHandler: @escaping (UIImage) -> Void) {
        
        let url = URL(string: imageUrlString)
        let urlrequest = URLRequest(url: url!)
        
        session.dataTask(with: urlrequest) { data, res, error in
            
            let image =  self.handleResponse(data: data, response: res)
          
            completionHandler(image ?? UIImage())
        }
        .resume()
    }
    
    //Function to download image using Combine.
    
    func asyncImageDownloadUsingCombine(imageUrlString: String) -> AnyPublisher<UIImage?, Error> {
        let url = URL(string: imageUrlString)!
        return session.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }
}
