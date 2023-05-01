//
//  NetworkUtility.swift
//  AynchronousImageDownloadDemo
//
//  Created by Prajakta on 28/04/23.
//

import Foundation

public final class NetworkUtility {
    
    public let session = URLSession(configuration: .default)
    static let shared = NetworkUtility()
    
    /// Generic function to call API.
    
    func callAPI<T: Codable>(urlString: String,
                             completionBlock: @escaping ((T?) -> Void)) {
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            guard let data = data, let res = response as? HTTPURLResponse, res.statusCode == 200
            else { return }
            completionBlock(try? JSONDecoder().decode(T.self, from: data))
        }
        dataTask.resume()
        
    }
    
}
