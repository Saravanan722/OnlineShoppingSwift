//
//  Product.swift
//  Event
//
//  Created by Innocrux on 27/04/23.
//

import SwiftUI

struct Product: Identifiable, Hashable {
    var id: UUID = UUID()
    var type: ProductType
    var title: String
    var subtitle: String
    var price: String
    var quantity: Int 
    var productImage: String = ""
    
}

enum ProductType: String, CaseIterable {
    case iphone = "iPhone"
    case ipad = "iPad"
    case macbook = "Mac Book"
    case desktop = "Mac Desktop"
    case appleWatch = "Apple Watch"
    case airpodds = "Air Pods"
} 


