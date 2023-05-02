//
//  Post.swift
//  Event
//
//  Created by Innocrux on 28/04/23.
//

import SwiftUI

struct Post: Identifiable,Hashable {
    var id = UUID().uuidString
    var imageURL: String
    
}

