//
//  SharedDataModel.swift
//  Event
//
//  Created by Innocrux on 28/04/23.
//

import SwiftUI

class SharedDataModel: ObservableObject {
    
    // Detail product data...
    
    @Published var detailProduct:Product?
    @Published var showDetailProduct: Bool = false
    
    // Mached Geometry Effect from search page...
    
    @Published var fromSearchPage: Bool = false
    
    //Liked Products...
    
    @Published var likedProducts: [Product] = []
    
    //Basket products
    
    @Published var cartProducts: [Product] = []
    
    // calculating  Total price...
    
    func getTotalPrice() -> String {
        var total:Int = 0
        cartProducts.forEach { product in
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            
            let quantity = product.quantity
            let pricetotal = quantity * price.integerValue
            
            total += pricetotal
        }
        
        return "$\(total)"
    }
    
}
