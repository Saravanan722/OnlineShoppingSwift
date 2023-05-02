//
//  CustomFrameView.swift
//  Online Shopping
//
//  Created by Innocrux on 02/05/23.
//

import SwiftUI

// Extending view to get screen bounds..

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
