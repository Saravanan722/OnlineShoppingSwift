//
//  MainPage.swift
//  Event
//
//  Created by Innocrux on 27/04/23.
//

import SwiftUI

struct MainPage: View {
    
    @State var currentTab: Tab = .Home
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    
    //Animation Namespace
    
    @Namespace var animation
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Tab View
            
            TabView(selection: $currentTab) {
                Home(animation:animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)
                LikedPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Liked)
                ProfilePage()
                    .environmentObject(sharedData)
                    .tag(Tab.Profile)
                CartPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Cart)
                
            }
            // Custom Tab Bar
            HStack(spacing: 0) {
                ForEach(Tab.allCases,id: \.self) { tab in
                    Button{
                        //updating tab
                        currentTab = tab
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio( contentMode: .fit)
                            .frame(width: 22, height: 22)
                        //Apling litle shadow
                            .background(
                                Color.purple.opacity(0.5)
                                    .cornerRadius(5)
                                //blubring
                                    .blur(radius: 5)
                                // making litle big...
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1:0)
                                
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color.purple: Color.black.opacity(0.3))
                    }
                }
                
            }
            .padding([.horizontal,.top])
            .padding(.bottom,10)
        }
        .background(Color.gray.ignoresSafeArea())
        .overlay(
            ZStack {
                //Detail Page...
                if let product = sharedData.detailProduct,sharedData
                    .showDetailProduct {
                    
                    ProductDetailView(product: product, animation: animation)
                        .environmentObject(sharedData)
                    
                    // adding transition...
                    
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
                
            }
        )
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
// Making Case Iteratable
// Tab Case
enum Tab : String, CaseIterable {
    
    case Home = "Home"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart"
    
}
