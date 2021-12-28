//
//  DetailViewController.swift
//  ShoppingListApp
//
//  Created by Sammy on 27.12.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var product : ProductModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = product?.title
        priceLbl.text = "\((product?.price)!)"
        descriptionLbl.text = product?.description
        imageView.downloaded(from: (product?.image)!)
        // Do any additional setup after loading the view.
    }
    

}
