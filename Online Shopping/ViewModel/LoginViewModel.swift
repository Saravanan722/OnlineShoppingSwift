//
//  LoginViewModel.swift
//  Event
//
//  Created by Innocrux on 30/04/23.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
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
            log_Status = false
        }
    }
    
    func register() {
        
        //Register call action here...
        withAnimation {
          //  log_Status = false
        }
    }
    
    func forgetPassword() {
        
        // Do action here...
        
    }
}

