//
//  CustomView.swift
//  Online Shopping
//
//  Created by Innocrux on 03/05/23.
//

import SwiftUI

struct CustomView: View {
    var image: String
    var text: String
    var color: String
    var action: (() -> ())?
    
    @StateObject var vm:LoginViewModel = LoginViewModel()
    
    var body: some View {
        HStack{
            Button(
                action: {
                    action?()
                },
                label: {
                    HStack{
                        Image(image)
                            .frame(width:32, height: 32)
                            .padding(.horizontal, 12)
                            .padding(.trailing,10)
                        
                        Text(text)
                            .bold()
                            .foregroundColor(Color.white)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(RoundedRectangle(cornerRadius: 25.0).fill(Color(color)))
                })
        }
        CustomView(
            image: "ic_login_apple",
            text: "Sign in with Apple",
            color: "black",
            action: {
                vm.performAppleSignIn()
            })
        .padding(.top, 5)
    }
}

struct CustomView_Previews: PreviewProvider {
    static var previews: some View {
        CustomView(image: "ic_login_apple", text: "Sign in with Apple", color: "black")
    }
}
