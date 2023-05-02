//
//  ContentView.swift
//  Online Shopping
//
//  Created by Innocrux on 30/04/23.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var log_Status: Bool = false
    var body: some View {
        
        Group {
            if log_Status {
                MainPage()
            } else {
                OnBordingPage()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
