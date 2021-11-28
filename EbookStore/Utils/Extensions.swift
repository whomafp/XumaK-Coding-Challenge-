//
//  Extensions.swift
//  EbookStore
//
//  Created by Miguel Ángel Fonseca Pérez on 27/11/21.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
// MARK: - UIImageView extension

extension UIImageView{
    /// This loadThumbnail function is used to download thumbnail image using urlString
    /// This method also using cache of loaded thumbnail using urlString as a key of cached thumbnail.
    func loadThumbnail(urlSting: String) {
        guard let url = URL(string: urlSting) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlSting as AnyObject) {
            DispatchQueue.main.async {
                self.image = imageFromCache as? UIImage
            }
            return
        }
        Networking.downloadImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: urlSting as AnyObject)
                self.image = UIImage(data: data)
            case .failure(_):
                DispatchQueue.main.async {
                    self.image = UIImage()
                }
            }
        }
    }
}

extension RangeReplaceableCollection {
    /// Returns a new Collection shuffled
    var shuffled: Self { .init(shuffled()) }
    /// Shuffles this Collection in place
    @discardableResult
    mutating func shuffledInPlace() -> Self  {
        self = shuffled
        return self
    }
    func choose(_ n: Int) -> SubSequence { shuffled.prefix(n) }
}

extension String {
    static var defaultNameValue: String { "Unknown" }
}

