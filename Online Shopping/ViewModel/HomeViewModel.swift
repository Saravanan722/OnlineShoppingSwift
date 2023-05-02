//
//  HomeViewModel.swift
//  Event
//
//  Created by Innocrux on 27/04/23.
//

import SwiftUI
import Combine


//Using combine to monitor search field if user leaves for .5 sec then start searching...
// to avoid memory issue

class HomeViewModel: ObservableObject {
    @Published var productType: ProductType = .iphone
    
    // Show more products
    @Published var showMoreProduct: Bool = false
    
    // Search bar data
    
    @Published var searchText:String = ""
    @Published var searchActivated:Bool = false
    @Published var searchedProducts: [Product]?
    var searchCancellable: AnyCancellable?
    
    
    
    
    //Sample Products
    @Published  var products: [Product] = [
        //Apple Watch's
        Product(type: .appleWatch, title: "Apple Watch", subtitle: "Ultra: Alphine Loop", price: "$12999", quantity: 1, productImage: "AppleWatchUltra"),
        Product(type: .appleWatch, title: "Apple Watch", subtitle: "Series 8: Black", price: "$1599",quantity: 1, productImage: "AppleWatc8"),
        Product(type: .appleWatch, title: "Apple Watch", subtitle: "Series 6: Red", price: "$1499",quantity: 1, productImage: "AppleWatch6"),
        Product(type: .appleWatch, title: "Apple Watch", subtitle: "Series 4: Black", price: "$1399",quantity: 1, productImage: "AppleWatch4"),
        //iPhone's
        Product(type: .iphone, title: "iPhone 14 pro max", subtitle: "A16 - purple", price: "$1999",quantity: 1, productImage: "iPhoneProMax"),
        Product(type: .iphone, title: "AiPhone13", subtitle: "A15 - pink", price: "$12999",quantity: 1, productImage: "iPhone13"),
        Product(type: .iphone, title: "iPhone12", subtitle: "A14 - blue", price: "$12999",quantity: 1, productImage: "iPhone12"),
        Product(type: .iphone, title: "iPhone11", subtitle: "A13 - white", price: "$12999",quantity: 1, productImage: "iPhone11"),
        Product(type: .iphone, title: "iPhone SE 2", subtitle: "A16 - purple", price: "$12999",quantity: 1, productImage: "iPhoneSE"),
        Product(type: .iphone, title: "iPhone15", subtitle: "A16 - gray", price: "$12999",quantity: 1, productImage: "iPhone15"),
        //iPad's
        Product(type: .ipad, title: "iPad Pro", subtitle: "M1 - Silver", price: "$1999",quantity: 1, productImage: "iPadPro"),
        Product(type: .ipad, title: "iPad mini", subtitle: "A14 - White", price: "$1999",quantity: 1, productImage: "iPadMini"),
        Product(type: .ipad, title: "iPad Air 4 ", subtitle: "A15 - Gray", price: "$1999",quantity: 1, productImage: "iPadAir"),
        // Mack Book's
        Product(type: .macbook, title: "MacBook Pro 16", subtitle: "M2 Max - Silver", price: "$1999", quantity: 1, productImage: "MacBookPro16"),
        Product(type: .macbook, title: "MacBook Pro", subtitle: "M1 - Gold", price: "$1999",quantity: 1, productImage: "MacBookPro"),
        Product(type: .macbook, title: "MacBook Air", subtitle: "M1 - Gray", price: "$1999",quantity: 1, productImage: "MacBookAir"),
        // Desktop's
        Product(type: .desktop, title: "Mac Studio", subtitle: "M1 Max - Silver", price: "$1999",quantity: 1, productImage: "MacStudio"),
        Product(type: .desktop, title: "Mac Mini", subtitle: "M2 Pro -Space Gray ", price: "$1999",quantity: 1, productImage: "MacMini"),
        Product(type: .desktop, title: "iMac", subtitle: "M1 - purple", price: "$1999",quantity: 1, productImage: "iMac"),
        // Airpods
        Product(type: .airpodds, title: "AirPods", subtitle: "Pro 2nd Gen", price: "$1999",quantity: 1, productImage: "AirPodsPro"),
        Product(type: .airpodds, title: "AirPods", subtitle: "3rd Gen", price: "$1999",quantity: 1, productImage: "AirPods3"),
        Product(type: .airpodds, title: "AirPods", subtitle: "2nd gen", price: "$1999",quantity: 1, productImage: "AirPods2"),
        
    ]
    
    @Published  var filterProduct: [Product] = []
    init(){
        
        filterProductByType()
        
        searchCancellable = $searchText.removeDuplicates()
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .sink(receiveValue: {str in
                if str != "" {
                    self.filterProductBySearch()
                }
                else {
                    self.searchedProducts = nil
                }
            })
    }
    
    func filterProductByType() {
        //Fillter product by Product Type
        
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
            
            // Since it will require mor memory so using lazy to perform more
                .lazy
                .filter { product in
                    return product.type == self.productType
                }
            // limiting results
             //   .prefix(4)
            DispatchQueue.main.async {
                // Since it will require mor memory so using lazy to perform more
                
                self.filterProduct = results.compactMap({product in
                    return product
                })
            }
        }
    }
    
    func filterProductBySearch() {
        //Fillter product by Product Type
        
        DispatchQueue.global(qos: .userInteractive).async {
            let results = self.products
            
            // Since it will require mor memory so using lazy to perform more
                .lazy
                .filter { product in
                    return product.title.lowercased().contains(self.searchText.lowercased())
                }
            // limiting results
                .prefix(4)
            DispatchQueue.main.async {
                // Since it will require mor memory so using lazy to perform more
                
                self.searchedProducts = results.compactMap({product in
                    return product
                })
            }
        }
    }
}


//VStack(spacing: 0) {
//
//    ScrollView(.horizontal, showsIndicators: false) {
//
//        HStack(spacing: 130) {
//            ForEach(EventType.allCases,id: \.self) { type in
//
//                eventTabView(type: type)
//
//            }
//        }
//        .padding()
//    }
//    .frame(maxWidth: .infinity, maxHeight: 40)
//    .border(Color(hex: 0xE0E0E0))
//
//    if eventData.showComleted {
//
//        ScrollView(.vertical, showsIndicators: false ) {
//
//            HStack(spacing: 25) {
//
//                ForEach(eventData.completedEvent){ event in
//
//                    // comletedEvent view
//                    comletedEvent(event: event)
//                }
//            }
//            .padding()
//
//        }
//
//    } else {
//        ScrollView(.vertical, showsIndicators: false ) {
//
//            HStack(spacing: 25) {
//
//                ForEach(eventData.upcomingEvent){ event in
//
//                    //  Up Coming Event view
//                    upComingEvent(event: event )
//                }
//            }
//            .padding()
//        }
//    }
//}
//.frame(maxWidth: .infinity, alignment: .leading)
//.navigationBarBackButtonHidden(true)
//.navigationBarTitleDisplayMode(.inline)
//.toolbar {
//    ToolbarItem(placement: .navigationBarLeading) {
//        HStack(spacing: 10 ){
//            Image("back")
//                .resizable()
//                .frame(width: 24, height: 24)
//
//            Text("Events")
//                .font(.system(size: 20, weight: .semibold))
//        }
//    }
//    ToolbarItem(placement: .navigationBarTrailing) {
//        HStack(spacing: 10 ){
//            Image("search")
//                .resizable()
//                .frame(width: 24, height: 24)
//        }
//    }
//}
//}
