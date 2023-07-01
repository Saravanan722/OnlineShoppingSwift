//
//  HomeView.swift
//  Online Shopping
//
//  Created by Innocrux on 03/05/23.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("token") var token: String?
    var body: some View {
        VStack {
            Text("Welcome")
                .font(.title)
                .bold()
                .padding()
                .padding(.top, 60)
            
            Spacer()
            
            Button(action: {
                token = nil
            }, label: {
                Text("Logout")
                    .fontWeight(.bold)
                    .font(.body)
                    .padding(.horizontal, 20)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(40)
                    .foregroundColor(.white)
            })
        }
    }
}


