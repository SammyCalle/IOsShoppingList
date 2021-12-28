//
//  Products.swift
//  ShoppingListApp
//
//  Created by Sammy on 20.12.2021.
//

import Foundation

struct Products : Decodable{
    let id : Int
    let title : String
    let price : Float
    let description : String
    let category : String
    let image  : String
    let rating : Rating
}
