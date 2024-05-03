# AynchronousImageDownloadDemo

## Overview

This demo is developed using Swift and UIKit and MVVM architecture and include Unit test cases. 
This contains logic for Asynchronous images download from server by 3 ways
1. Using Aync-await 2. Using Combine 3. Using Closure

## Asynchronous images download

### Using Aync-await

Check below function to download images asynchronously using async-await

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
    
    usage:
    
        Task  {
            self.albumImgView.image = await ImageDownloader().asyncImageDownloadUsingAsyncAwait(imageUrlString: album.thumbnailURL)
        }

### Using Combine

Check below function to download images asynchronously using Combine

    func asyncImageDownloadUsingCombine(imageUrlString: String) -> AnyPublisher<UIImage?, Error> {
        let url = URL(string: imageUrlString)!
        return session.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError({ $0 })
            .eraseToAnyPublisher()
    }

    usage:

        ImageDownloader().asyncImageDownloadUsingCombine(imageUrlString: album.thumbnailURL)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in
                
            }, receiveValue: {[weak self] image in
                self?.albumImgView.image = image
            })
            .store(in: &cancellables)

### Using Closure

Check below function to download images asynchronously using closure

    func asyncImageDownloadUsingClosure(imageUrlString: String, completionHandler: @escaping (UIImage) -> Void) {
        
        let url = URL(string: imageUrlString)
        let urlrequest = URLRequest(url: url!)
        
        session.dataTask(with: urlrequest) { data, res, error in
            
            let image =  self.handleResponse(data: data, response: res)
          
            completionHandler(image ?? UIImage())
        }
        .resume()
    }

    usage:
    
        ImageDownloader().asyncImageDownloadUsingClosure(imageUrlString: album.thumbnailURL,
                                                         completionHandler: {[weak self] image in
            DispatchQueue.main.async {
                self?.albumImgView.image = image
            }
        })
