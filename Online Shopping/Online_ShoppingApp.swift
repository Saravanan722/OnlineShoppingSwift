//
//  Online_ShoppingApp.swift
//  Online Shopping
//
//  Created by Innocrux on 30/04/23.
//

import SwiftUI

@main
struct Online_ShoppingApp: App {
    
    @AppStorage("token") var token: String?
    
    var body: some Scene {
        WindowGroup {
            if token != nil {
                CustomView(image:" ic_login_apple", text: "Sign in with Apple", color: "block")
            } else {
                MainPage()
            }
        }
    }
}
