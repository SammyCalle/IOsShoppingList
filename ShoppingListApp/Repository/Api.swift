//
//  Api.swift
//  ShoppingListApp
//
//  Created by Sammy on 20.12.2021.
//

import Foundation
import UIKit


protocol ProductManagerDelegate{
    func didGetTheProdutcs(_ productManager: ProductManager, product: [ProductModel])
    func didFailWithError(error : Error)
}

struct ProductManager {
    let productURL = "https://fakestoreapi.com/"
    
    var delegate: ProductManagerDelegate?
    
    func fetchProducts(){
        let urlRequest = productURL + "products"
        performRequest(with: urlRequest)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let product = self.parseJSON(safeData) {
                        self.delegate?.didGetTheProdutcs(self, product: product)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ productsData: Data) -> [ProductModel]? {
        let decoder = JSONDecoder()
        var productList = [ProductModel]()
        do {
            let decodedData = try decoder.decode([Products].self, from: productsData)
            for product in decodedData{
                let id = product.id
                let title = product.title
                let price = product.price
                let description = product.description
                let category = product.category
                let image = product.image
                let productObject = ProductModel(id: id, title: title, price: price, description:description,category:category,image:image)
                productList.append(productObject)
            }
            return productList
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
