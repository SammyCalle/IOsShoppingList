//
//  ViewController.swift
//  ShoppingListApp
//
//  Created by Sammy on 19.12.2021.
//

import UIKit
import CoreLocation

class ProductViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var productsList = [ProductModel]()
    
    var productManager = ProductManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productManager.delegate = self
        productManager.fetchProducts()
        tableView.delegate = self
        tableView.dataSource = self
    
        
    }
    
}

//MARK: - ProductManagerDelegate
extension ProductViewController: ProductManagerDelegate {
    func didGetTheProdutcs(_ productManager: ProductManager, product: [ProductModel]) {
        for item in product{
            print(item.title)
            print(item.category)
        }
        self.productsList = product
        DispatchQueue.main.async { [self] in
            self.tableView.reloadData()
        }
        
    }
    func didFailWithError(error: Error) {
        print(error)
    }
}
//MARK: - ProductTableViewDataSource
extension ProductViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsList.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = productsList[indexPath.row].title.capitalized
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController{
            destination.product = productsList[tableView.indexPathForSelectedRow!.row]
        }
    }
    
}
