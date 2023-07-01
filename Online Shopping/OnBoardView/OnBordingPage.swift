//
//  OnBordingPage.swift
//  Event
//
//  Created by Innocrux on 30/04/23.
//

import SwiftUI

// To use the custom font on all pages...

let customFont =  "raleway-Regular"

struct OnBordingPage: View {
    // Showing login page...
    
    @State var showLoginPage: Bool = false
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Find your\nGadget")
                .font(.system(size: 55).bold())
                .fontWeight(.bold)
                .foregroundColor(.white)
            
            Image("Onboard")
                .resizable()
                .aspectRatio( contentMode: .fit)
            
            Button{
                
                withAnimation {
                    showLoginPage = true
                }
                
            } label: {
                Text("Get Started")
                    .font(.system(size: 18).bold())
                    .fontWeight(.semibold)
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.purple)
                    .background(.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
            }
            .padding(.horizontal, 30)
            
            // Adding some adjustment only for larger display..
            
            .offset(y: getRect().height < 750 ? 20 : 40)
            
            Spacer()
        }
        .padding()
        .padding(.top, getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cyan)
        .overlay(Group {
            if showLoginPage {
                LoginPage()
                    .transition(.move(edge: .bottom))
            }
        })
    }
}

