//
//  LoginPage.swift
//  Event
//
//  Created by Innocrux on 30/04/23.
//

import SwiftUI

struct LoginPage: View {
    
    @StateObject var loginData: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            
                Text("Welcome\n Back")
                    .font(.system(size: 55).bold())
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .frame(height: getRect().height / 3.5)
                    .background(
                        ZStack {
                            //Gradient circle..
                            LinearGradient(colors: [.orange, .brown, .purple], startPoint: .top, endPoint: .bottom)
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                .padding(.trailing)
                                .offset(y: -20)
                                .ignoresSafeArea()
                            
                            Circle()
                                .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                                .frame(width: 30, height: 30)
                                .blur(radius: 3)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                                .padding(30)

                            Circle()
                                .strokeBorder(Color.white.opacity(0.3),lineWidth: 3)
                                .frame(width: 23, height: 23)
                                .blur(radius: 2)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .padding(.leading, 30)
                        }
                    )
        
            
            ScrollView(.vertical, showsIndicators: false) {
                
                //Login Page...
                VStack(spacing: 15) {
                    Text(loginData.registerUser ? "register" : "Login")
                        .font(.system(size: 18).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Custom textField...
                    customTextField(icon: "envelope",
                                    title: "Email",
                                    hint: "Email ID",
                                    value: $loginData.email,
                                    showPassword: $loginData.showPassword)
                    .padding(.top, 30)
                    
                    customTextField(icon: "lock",
                                    title: "Password",
                                    hint: "Password",
                                    value: $loginData.password,
                                    showPassword: $loginData.showPassword)
                    .padding(.top, 10)
                    
                    //Register re enter password...
                    
                    if loginData.registerUser {
                        customTextField(icon: "envelope",
                                        title: "Re-Enter-Password",
                                        hint: "Re-Enter-Password",
                                        value: $loginData.re_Enter_Password,
                                        showPassword: $loginData.showRe_Enter_Password)
                        .padding(.top, 10)
                    }
                    
                    //Forget Password button...
                    
                    Button {
                        loginData.forgetPassword()
                    } label: {
                        Text("Forget Password?")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(.purple)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top, 8)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // login button...
                    
                    Button {
                        loginData.log_Status = true
                    } label: {
                        Text("Login")
                            .font(.system(size: 17).bold())
                            .fontWeight(.semibold)
                            .padding(.vertical,20)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .background(Color.purple)
                            .cornerRadius(15)
                            .shadow(color: Color.black.opacity(0.07), radius: 5,x: 5,y: 5)
                    }
                    .padding(.top, 25)
                    .padding(.horizontal)
                    
                    //Register user button...
                    
                    Button {
                        withAnimation {
                            loginData.registerUser.toggle()
                        }
                    } label: {
                        Text(loginData.registerUser ? "Back to login" : "Create account")
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                            .foregroundColor(.purple)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top, 8)
                }
                .padding(30)
                
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                
                //aplying custom corners...
                .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25 ))
                .ignoresSafeArea()
            )
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.cyan)
        .onChange(of: loginData.registerUser) { newValue in
            
            loginData.email = ""
            loginData.password = ""
            loginData.re_Enter_Password = ""
            loginData.showRe_Enter_Password = false
            loginData.showPassword = false
            
        }
    }
    
    @ViewBuilder
    
    func customTextField(icon: String, title: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>) -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            Label {
                Text(title)
                    .font(.system(size: 14))
            } icon: {
                Image(systemName: icon)
            }
            .foregroundColor(Color.black.opacity(0.8))
            
            
            if title.contains("Password") && !showPassword.wrappedValue {
                SecureField(hint, text: value)
                    .padding(.top, 2)
            } else {
                TextField(hint, text: value)
                    .padding(.top, 2)
            }
            Divider()
                .background(Color.black.opacity(0.4))
        }
        
        // Showing show Button bar passwor Field...
        .overlay(
            
                Group {
                    
                    if title.contains("Password") {
                        Button(action: {
                            showPassword.wrappedValue.toggle()
                        
                    }, label: {
                        Text(showPassword.wrappedValue ? "Hide" : "Show")
                            .font(.system(size: 13).bold())
                            .foregroundColor(.purple)
                    })
                        .offset(y: 8)
                    }
                }
            ,alignment: .trailing
        )
    }
}


