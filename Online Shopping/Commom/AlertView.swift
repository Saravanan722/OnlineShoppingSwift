//
//  AlertView.swift
//  Online Shopping
//
//  Created by Innocrux on 05/06/23.
//

import SwiftUI

struct AlertView: View {
    @State private var showModel = false
    var body: some View {
        ZStack {
            Button {
                showModel = true
            }label: {
                Text("Click Me")
                    .font(.system(size: 40, weight: .heavy, design: .rounded))
                    .foregroundColor(.brown)
                    .padding(.vertical, 20)
                    .padding(.horizontal, 40)
                    .background(.black.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .offset(y: -100)
            ModelView(showingModel: $showModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .statusBar(hidden: true)
    }
}


