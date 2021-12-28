//
//  ProductModel.swift
//  ShoppingListApp
//
//  Created by Sammy on 21.12.2021.
//

import Foundation
import UIKit

struct ProductModel {
    var id : Int
    var title : String
    var price : Float
    var description : String
    var category : String
    var image  : String
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIImageView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIImageView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
