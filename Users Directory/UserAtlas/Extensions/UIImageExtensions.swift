//
//  UIImageExtensions.swift
//  Users Directory
//
//  Created by Ajay Gadwal on 21/05/26.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImageFromUrl(
        _ urlString: String,
        thumbnailUrl: String? = nil
    ) {
        if let thumbnailUrl = thumbnailUrl,
           let thumbURL = URL(string: thumbnailUrl) {
            URLSession.shared.dataTask(with: thumbURL) { [weak self] data, _, _ in
                guard let data = data,
                      let image = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    self?.image = image
                }
            }.resume()
        }
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data,
                  let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                
                self?.image = image
                
            }
        }.resume()
    }
}
