//
//  Home.swift
//  Event
//
//  Created by Innocrux on 27/04/23.
//

import SwiftUI

struct Home: View {
    var animation: Namespace.ID
    @StateObject var homeData:HomeViewModel = HomeViewModel()
    
    // Shared Data
    @EnvironmentObject var sharedData: SharedDataModel
    
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                
                // search bar
                
                ZStack {
                    if homeData.searchActivated {
                        searchBar()
                    } else {
                        searchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width: getRect().width / 1.6)
                .padding(.horizontal,25)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        homeData.searchActivated = true
                    }
                }
                
                Text("Order Online")
                    .font(.system(size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top  )
                    .padding(.horizontal,25)
                
                // Product Tab
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(ProductType.allCases,id: \.self) { type in
                            productTabView(type: type)
                        }
                    }
                    .padding(.horizontal,28)
                }
                .padding(.top,25)
                
                // Product Page
                ScrollView(.horizontal, showsIndicators: false ) {
                    
                    HStack(spacing: 25) {
                        
                        ForEach(homeData.filterProduct){ product in
                            
                            // product card view
                            productCardView(product: product)
                        }
                    }
                    .padding(.horizontal,25)
                    .padding(.bottom)
                    .padding(.top,30)
                }
                .padding(.top,30)
                
                // See more button
                // this button will show all products on the current product type
                // since here were showing only 4..
                
                Button {
                    homeData.showMoreProduct = true
                } label: {
                    // since we need image are right
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("see more")
                    }
                    .font(.system(size: 15).bold())
                    .foregroundColor(Color.purple)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
                .padding(.top,5)
            }
            .padding(.vertical  )
        }
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .background(Color.gray.opacity(0.1))
        // Updating dat whenever tab changes
        .onChange(of: homeData.productType) { newValue in
            homeData.filterProductByType()
            
        }
        .sheet(isPresented: $homeData.showMoreProduct) {
        } content: {
            
            MoreProductView()
        }
        
         // Displaying search view..
        
        .overlay {
            ZStack {
                if homeData.searchActivated {
                    SearchView(animation: animation )
                        .environmentObject(homeData)
                }
            }
        }
    }
    
    // since we are adding method geometry effect
    // avoiding code replication
    
    @ViewBuilder
    func searchBar()-> some View {
        HStack(spacing: 15) {
            Image("search")
                .font(.title2)
                .foregroundColor(.gray)
            // since a need seperate view for search bar
            TextField("Search", text: .constant(""))
                .disabled(true)
            
        }
        .padding(.vertical,10 )
        .padding(.horizontal)
        .background(
            Capsule()
                .strokeBorder(Color.gray, lineWidth: 0.8)
        )
        
    }
    
    @ViewBuilder
    func productTabView(type: ProductType) -> some View {
        Button {
            // Update current tab
            withAnimation {
                homeData.productType = type
            }
        } label: {
            Text(type.rawValue)
                .font(.system(size: 15))
                .fontWeight(.semibold)
            // Changing Color based on current product Type
                .foregroundColor(homeData.productType == type ? Color.purple: Color.gray)
                .padding(.bottom,10)
            // Add indicator at bottom
                .overlay(
                    // Adding mached geometry Effect
                    ZStack {
                        if homeData.productType == type {
                            Capsule()
                                .fill(Color.brown)
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        } else {
                            if homeData.productType == type {
                                Capsule()
                                    .fill(Color.clear)
                                    .frame(height: 2)
                            }
                        }
                    }
                    .padding(.horizontal, -5) ,alignment: .bottom)
        }
    }
    
    @ViewBuilder
    func productCardView(product: Product) -> some View {
        
        VStack(spacing: 10) {
         //Adding matched Geometry effect...
            
            ZStack {
                
                if sharedData.showDetailProduct {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                }
                else {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                }
            }
                .frame(width: getRect().width / 2.5, height: getRect().height / 2.5)
            
            // Moving image to top to look like its fixed at half top...
                .offset(y: -40)
                .padding(.bottom,-80)
            
            Text(product.title)
                .font(.title3)
                .foregroundColor(Color.black)
            
            Text(product.subtitle)
                .font(.title3)
                .foregroundColor(Color.gray)
            
            Text(product.price)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color.purple)
                .padding(.top,5)
        }
        .padding(.horizontal,25)
        .padding(.bottom,22)
        .background(
            Color.white
                .cornerRadius(25)
        )
        
        // Showing product detail when you tapped...
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

