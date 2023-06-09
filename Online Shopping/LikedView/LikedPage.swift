//
//  LikedPage.swift
//  Event
//
//  Created by Innocrux on 28/04/23.
//

import SwiftUI

struct LikedPage: View {
    
    // Shared data...
    @EnvironmentObject var sharedData: SharedDataModel

    // Delete options...
    
    @State var showDeleteOption: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    HStack {
                        Text("Favourites")
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
                                .frame(width: 25, height: 25)
                            
                        }
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)
                    }
                    
                    //checking if liked products are empty...
                    
                    if sharedData.likedProducts.isEmpty {
                        Group {
                            Image("NoLiked")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .clipShape(Circle())
                            
                            
                            Text("No favourites yet..")
                                .font(.system(size: 25).bold())
                                .fontWeight(.semibold)
                            
                            Text("Hit the the like button on each products page to save favourite ones..")
                                .font(.system(size: 18).bold())
                                .foregroundColor(.black)
                                .padding(.horizontal)
                                .padding(.top)
                                .multilineTextAlignment(.center)
                        }
                    } else {
                        
                        //Displaying products...
                        
                        VStack(spacing: 15) {
                            
                            ForEach(sharedData.likedProducts) { product in
                                
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
                                    
                                    CardView(product: product)
                                }
                            }
                        }
                        .padding(.top,25)
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.07).ignoresSafeArea())
        }
    }
    
    @ViewBuilder
    func CardView(product: Product) -> some View {
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
                
                Text("Type: \(product.type.rawValue)")
                    .font(.system(size: 13).bold())
                    .foregroundColor(Color.gray)
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
    
    func deletdProduct(product: Product) {
        
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }) {
          let _ = withAnimation {
                // removing
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}


