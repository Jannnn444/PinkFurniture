//
//  Product.swift
//  MyPinkFurnitureStore
//
//  Created by Hualiteq International on 2025/4/29.
//

import Foundation

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var description: String
    var supplier : String
    var price: Int
    
}

var productList = [
        Product(name: "Leather Couch",
                image: "fn1",
                description: "Soft and Comfy",
                supplier: "IKEA",
                price: 350),
        Product(name: "Sweet Couch",
                image: "fn2",
                description: "Excellent",
                supplier: "IKEA",
                price: 350),
        Product(name: "Crocodile Couch",
                image: "fn3",
                description: "Neat",
                supplier: "Walmart",
                price: 350),
        Product(name: "Good Couch",
                image: "fn4",
                description: "Sexy",
                supplier: "IKEA",
                price: 350),
        Product(name: "Dream Couch",
                image: "fn5",
                description: "Hot and trendy",
                supplier: "IKEA",
                price: 350),
        Product(name: "Niche Couch",
                image: "fn6",
                description: "Fresh",
                supplier: "IKEA",
                price: 350)
]
