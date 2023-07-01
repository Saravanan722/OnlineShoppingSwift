//
//  ModelView.swift
//  Online Shopping
//
//  Created by Innocrux on 05/06/23.
//

import SwiftUI

struct ModelView: View {
    @Binding var showingModel: Bool
    @State private var isDraging:Bool  = false

    @State private var cureHeight: CGFloat  = 400
    let minHeight: CGFloat  = 400
    let maxHeight: CGFloat  = 700
    var body: some View {
        ZStack(alignment: .bottom) {
            if showingModel {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showingModel = false
                    }
                mainView
                    .transition(.move(edge: .bottom))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
       // .animation(.easeInOut)
    }
    
    var mainView: some View {
        VStack {
            ZStack {
                Capsule()
                    .frame(width: 40, height: 6)
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .background(.white.opacity(0.00001))
            .gesture(dragGesture)
            
            ZStack {
                VStack {
                    
                    Text("Money Awaiting")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(hex: 0x393E52))
        
                    
                    Text("Money Awaiting")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(hex: 0x393E52))
                        
                }
                .padding(.horizontal, 30)
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 35)
        }
        .frame(minHeight: cureHeight)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                Rectangle()
                    .frame(height: cureHeight / 2)
            }
            .background(.white)
        )
       // .animation(isDraging ? nil : .easeInOut(duration: 0.45))
    }
        
    
    @State private var prevDragtransation = CGSize.zero
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged { Val in
                if !isDraging {
                    isDraging = true
                }
                let dragAmount = Val.translation.height - prevDragtransation.height
                if cureHeight > maxHeight || cureHeight < minHeight {
                    cureHeight -= dragAmount / 6
                } else {
                    cureHeight -= dragAmount
                }
                prevDragtransation = Val.translation
            }
            .onEnded { Val in
                prevDragtransation = .zero
                
                isDraging = false
                if cureHeight > maxHeight {
                    cureHeight = maxHeight
                }
                else if cureHeight < minHeight {
                    cureHeight = minHeight
                    
                }
            }
    }
}
