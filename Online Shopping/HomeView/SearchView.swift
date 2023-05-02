//
//  SearchView.swift
//  Event
//
//  Created by Innocrux on 27/04/23.
//

import SwiftUI

struct SearchView: View {
    // Shared data...
    @EnvironmentObject var sharedData: SharedDataModel
    
    var animation: Namespace.ID
    @EnvironmentObject var homeData:HomeViewModel
    
    // Activating text field with the help of FocusState...
    
    @FocusState var startTF:Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // Search bar
            
            HStack(spacing: 20 ) {
                Button {
                    withAnimation {
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    
                    //Reseting ...
                    sharedData.fromSearchPage = false
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                
                // Search Bar
                
                HStack(spacing: 15) {
                    Image("search")
                        .font(.title2)
                        .foregroundColor(.gray)
                    
                    // since a need seperate view for search bar
                    
                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                    
                }
                .padding(.vertical,12 )
                .padding(.horizontal)
                .background(
                    Capsule()
                        .strokeBorder(Color.purple, lineWidth: 0.8)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing,20 )
            }
            .padding([.horizontal])
            .padding(.top)
            .padding(.bottom,10)
            
            // Showing prograress if searching...
            // else showing no results found if empty...
            
            if let products = homeData.searchedProducts {
                if products.isEmpty {
                    // no results founds...
                    VStack(spacing: 10){
                        Image("NotFound")
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .padding(.top,60)
                        Text("Item Not Found")
                            .font(.system(size: 22).bold())
                        
                        Text("Try a more generic search term or try looking for alternative products.")
                            .font(.system(size: 22).bold())
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                        
                    }
                    .padding()
                    
                }else {
                    // Filter Results
                    
                    ScrollView(.vertical, showsIndicators:  false) {
                        
                        VStack(spacing: 0) {
                            //Founds Text...
                            
                            Text("Found \(products.count) results")
                                .font(.system(size: 24).bold())
                                .padding(.vertical)
                            
                            //Staggered Gird...
                            StaggeredGird(columns: 1,spacing: 20, list: products) { product in
                                
                                // Card View...
                                productCardView(product: product)
                                
                            }
                        }
                        .padding()
                        
                    }
                }
            }
            else{
                ProgressView()
                    .padding(.top,30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(
            Color.cyan.ignoresSafeArea()
        )
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 ) {
                startTF = true
                
            }
        }
    }
    
    @ViewBuilder
    func productCardView(product: Product) -> some View {
        
        VStack(spacing: 10) {
            
            ZStack{
                if sharedData.showDetailProduct {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .opacity(0)
                } else {
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
            .frame(width: getRect().width / 2.5, height: getRect().height / 2.5)
            
            // Moving image to top to look like its fixed at half top...
            .offset(y: -80)
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
        .padding(.top,50)
        .onTapGesture {
            withAnimation(.easeInOut) {
                sharedData.fromSearchPage = true
                sharedData.detailProduct = product
                sharedData.showDetailProduct = true
            }
        }
        
    }
}

//struct SearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchView()
//
//    }
//}
