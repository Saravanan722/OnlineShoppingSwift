//
//  CartPage.swift
//  Event
//
//  Created by Innocrux on 28/04/23.
//

import SwiftUI

struct CartPage: View {
    
    // Shared data...
    @EnvironmentObject var sharedData: SharedDataModel

    // Delete options...
    
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack(spacing: 10){
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    // Showing Total and check out button..
                    
                    
                    
                            
                            HStack {
                                Text("Total")
                                    .font(.system(size: 14).bold())
                                    .fontWeight(.semibold)
                                
                                Spacer()
                                
                                Text(sharedData.getTotalPrice())
                                    .font(.system(size: 18).bold())
                                    .foregroundColor(Color.purple)
                                
                            
                            Button {
                                
                            }label: {
                                Text("Check Out")
                                    .font(.system(size: 18).bold())
                                    .foregroundColor(Color.white)
                                    .padding(.vertical,10)
                                    .frame(maxWidth: .infinity)
                                    .background(.purple)
                                    .cornerRadius(15)
                                    .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                            }
                            
                            .padding(.vertical)
                        }
                        .padding(.horizontal, 25)
                    
                    
                    VStack {
                        HStack {
                            Text("Basket")
                                .font(.system(size: 28).bold())
                            
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    showDeleteOption.toggle()
                                }
                                
                            } label: {
                                
                                Image("Delete")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25    , height: 25)
                                
                            }
                            .opacity(sharedData.cartProducts.isEmpty ? 0 : 1)
                        }
                        
                        //checking if liked products are empty...
                        
                        if sharedData.cartProducts.isEmpty {
                            Group {
                                Image("NoBasket")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                                    .padding(.top,35)
                                
                                Text("No Item added..")
                                    .font(.system(size: 25).bold())
                                    .fontWeight(.semibold)
                                
                                Text("Hit the the like button on each products page to save favourite ones..")
                                    .font(.system(size: 18).bold())
                                    .foregroundColor(.gray)
                                    .padding(.horizontal)
                                    .padding(.top)
                                    .multilineTextAlignment(.center)
                                
                            }
                        } else {
                            
                            //Displaying products...
                            
                            VStack(spacing: 15) {
                                
                                ForEach($sharedData.cartProducts) { $product in
                                    
                                    HStack(spacing: 0) {
                                        if showDeleteOption {
                                            Button {
                                                deletdProduct(product: product)
                                            } label: {
                                                Image(systemName: "minus.circle.fill")
                                                    .font(.title2)
                                                    .foregroundColor(.red)
                                            }
                                            .padding(.trailing)
                                        }
                                        
                                        CartView(product: $product)
                                    }
                                }
                            }
                            .padding(.top,25)
                            .padding(.horizontal)
                            
                        }
                    }
                    .padding()
                }
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.04).ignoresSafeArea())
        }
    }
    
    func deletdProduct(product: Product) {
        
        if let index = sharedData.cartProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
          let _ = withAnimation {
                // removing
                sharedData.cartProducts.remove(at: index)
            }
        }
    }
}


struct CartView: View {
    
    // Making product as Binding so as update in real time...
    
    @Binding var product: Product
    
    var body: some View {
        
        HStack(spacing: 15 ) {
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 15) {
                
                Text(product.title)
                    .font(.system(size: 20).bold())
                    .foregroundColor(Color.black)
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.system(size: 18).bold())
                    .foregroundColor(Color.gray)
                
                // Quantity buttons...
                HStack(spacing: 10) {
                    Text("Quantity: ")
                        .font(.system(size: 18).bold())
                        .foregroundColor(Color.gray)
                    Button {
                        product.quantity = ( product.quantity > 0 ?  (product.quantity - 1) : 0)
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20,height: 20)
                            .background(Color.cyan)
                            .cornerRadius(4)
                    }
                    
                    Text("\(product.quantity)")
                        .font(.system(size: 18).bold())
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                    
                    Button {
                        product.quantity += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20,height: 20)
                            .background(Color.cyan)
                            .cornerRadius(4)
                    }
                }
            }
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color.white
                .cornerRadius(10)
        )
    }
}
