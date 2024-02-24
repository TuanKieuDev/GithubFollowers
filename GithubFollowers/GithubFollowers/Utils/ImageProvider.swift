//
//  ImageProvider.swift
//  GithubFollowers
//
//  Created by Tuấn Kiều on 24/02/2024.
//

import Foundation
import UIKit

final class ImageProvider {
    static let shared = ImageProvider()

    private let cache = NSCache<NSString, UIImage>()

    private init() {}

    public func fetchData(url: URL, completion: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            completion(image)
            return
        }

        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                self?.cache.setObject(image, forKey: url.absoluteString as NSString)
                completion(image)
            }
        }
        dataTask.resume()
    }
}
