//
//  LoginViewModel.swift
//  Event
//
//  Created by Innocrux on 30/04/23.
//

import SwiftUI
import AuthenticationServices

class LoginViewModel: NSObject,ObservableObject {
    
    //Login properties...
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    //register Propeties...
    @Published var registerUser: Bool = false
    @Published var re_Enter_Password: String = ""
    @Published var showRe_Enter_Password: Bool = false
    
    // Log Status...
    
    @AppStorage("log_Status") var log_Status: Bool = false

    func login() {
        
        //login call action here...
        
        withAnimation {
            log_Status = true
        }
    }
    
    func register() {
        
        //Register call action here...
        withAnimation {
            log_Status = true
        }
    }
    
    func forgetPassword() {
        
        // Do action here...
        
    }
    
    
}

extension LoginViewModel: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController,
                                 didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIdCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let token = appleIdCredential.identityToken?.base64EncodedString()  else {
                return
            }
            print(token)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print(error)
    }
    
     func performAppleSignIn() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.performRequests()
    }
}
