//
//  ProductDetailView.swift
//  Event
//
//  Created by Innocrux on 28/04/23.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    
    // shared data model
    
    // For matched Geometry  effect...
    var animation: Namespace.ID
    
    @EnvironmentObject var shareData: SharedDataModel
    
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        
        VStack {
            
            // Tittle Bar and product image..
            VStack {
                
                //Tittle Bar
                
                HStack {
                    Button {
                        
                        //Closing View..
                        
                        withAnimation(.easeInOut) {
                            shareData.showDetailProduct = false
                        }
                        
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    Button {
                        addToLiked()
                        
                    } label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .foregroundColor(isLiked() ? .red :  Color.black.opacity(0.7))
                    }
                }
                .padding()
                
                //Product image..
                // adding matched Geometry  effect...
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)\(shareData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                    .frame(maxHeight: .infinity)
                
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            
            //Product details...
            ScrollView(.vertical, showsIndicators: false) {
                
                //Product Data..
                
                VStack(alignment: .leading, spacing: 15) {
                    
                    Text(product.title)
                        .font(.system(size: 20).bold())
                        .foregroundColor(Color.black)
                    
                    Text(product.subtitle)
                        .font(.system(size: 18).bold())
                        .foregroundColor(Color.gray)
                    
                    Text("Get Apple Tv+ free for a year")
                        .font(.system(size: 16).bold())
                        .padding(.top)
                        .foregroundColor(Color.black)
        
                    Text("Shop Apple accessories for Apple Watch, iPhone, iPad, iPod and Mac.‎What’s New · ‎Made by Apple · ‎Only at Apple · ‎Apple TV & Home Accessories")
                        .font(.system(size: 16).bold())
                        .padding(.top)
                        .foregroundColor(Color.gray)
                    
                    Button {
                        
                    } label: {
                        
                        //Since we need imga at right..
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full Description")
                        }
                        .font(.system(size: 16).bold())
                        .foregroundColor(Color.purple)
                        
                    }
                    
                    HStack {
                        Text("Total")
                            .font(.system(size: 16).bold())
                            
                        Spacer()
                        
                        Text(product.price)
                            .font(.system(size: 15).bold())
                            .fontWeight(.semibold)
                            .foregroundColor(Color.purple)
                    }
                    .padding(.vertical,20)
                    
                    Button{
                        addToCart()
                    } label: {
                        Text("\(isAddedToCart() ? "Added" : "add")  to basket")
                            .font(.system(size: 20).bold())
                            .foregroundColor(Color.white)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(
                                Color.purple
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                            )
                    }
                    
                }
                .padding([.horizontal, .bottom], 20)
                .padding(.top, 25)
               .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                // CorrnerRedius for only top side...
                    .cornerRadius(25)
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .animation(.easeInOut, value: shareData.likedProducts)
        .animation(.easeInOut, value: shareData.cartProducts)
        .background(
            Color.gray
                .ignoresSafeArea()
        )
    }
    
    func isLiked()-> Bool {
        
        return shareData.likedProducts.contains { product in
            
            return self.product.id == product.id
             
        }
    }
    
    func isAddedToCart()-> Bool {
        
        return shareData.cartProducts.contains { product in
            
            return self.product.id == product.id
    
        }
    }
    
    func addToLiked() {
        
        if let index = shareData.likedProducts.firstIndex(where: {product in
            return self.product.id == product.id
        }) {
            // Removed from liked...
            shareData.likedProducts.remove(at: index)
        }
        else {
            // add to liked...
            shareData.likedProducts.append(product)
        }
    }
    
    func addToCart() {
        
        if let index = shareData.cartProducts.firstIndex(where: {product in
            return self.product.id == product.id
        }) {
            // Removed from liked...
            shareData.cartProducts.remove(at: index)
        }
        else {
            // add to liked...
            shareData.cartProducts.append(product)
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
