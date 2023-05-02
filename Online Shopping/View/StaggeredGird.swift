//
//  StaggeredGird.swift
//  Event
//
//  Created by Innocrux on 27/04/23.
//

import SwiftUI

// Custom view builder....

// T -> is to hold the identifiable collection of data...

struct StaggeredGird<Content: View, T: Identifiable>: View where T: Hashable {
    
    // It will return each object from collection to   build view
    
    var content: (T) -> Content
    var list: [T]
    //columns
    var columns: Int
    
    //properties..
    var showsIndicators: Bool
    var spacing:CGFloat
    
    init(
        columns: Int,showsIndicators: Bool = false, spacing: CGFloat = 10 ,list: [T], @ViewBuilder content: @escaping (T)->Content) {
            self.content = content
            self.list = list
            self.spacing = spacing
            self.showsIndicators = showsIndicators
            self.columns = columns
        }
    
    // Staggered Gird function
    
    func setUpList() ->[[T]] {
        
        // creating  empty sub arrays of columns count...
        var girdArray: [[T]] = Array(repeating: [], count: columns)
        
        var currentIndex: Int = 0
        for object in  list {
            girdArray[currentIndex].append(object)
            
            // Increasing index count...
            // and reseting if overbounds the columns count..
            if currentIndex == (columns - 1) {
                currentIndex = 0
            } else {
                currentIndex += 1
            }
        }
        return girdArray
        
        // spiliting array for Vstack oriented view...
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: showsIndicators) {
            
            HStack( alignment: .top, spacing: 20) {
                ForEach(setUpList(),id: \.self) { columnsData in
                    
                    //For optimized using LazyStack...
                    LazyVStack(spacing: spacing) {
                        ForEach(columnsData) { object in
                            content(object)
                        }
                    }
                    .padding(.top, getIndex(values: columnsData) == 1 ? 80: 0)
                }
            }
            //Only vertical padding...
            //horizontal padding will be users optional...
            .padding(.vertical)
        }
    }
    
    // Moving second row little down...
    
    func getIndex(values: [T]) -> Int {
        let index  = setUpList().firstIndex { t in
            return t == values
            
        } ?? 0
        return index
    }
}

struct StaggeredGird_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
