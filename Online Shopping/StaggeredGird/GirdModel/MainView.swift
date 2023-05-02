//
//  MainView.swift
//  Event
//
//  Created by Innocrux on 27/04/23.
//

import SwiftUI

struct MainView: View {
    @State var posts: [Post] = []
    
    // To show dynamic...
    @State var columns:Int = 2
    
    // Smooth Hero effect...
    @Namespace var animation
    
    var body: some View {
        NavigationView {
            StaggeredGird(columns: columns, list: posts, content: { post in
                
                // post card view..
                
                //Text(post.imageURL)
                PostCardView(post: post)
                    .matchedGeometryEffect(id: post.id, in: animation)
                    .onAppear {
                        print(post.imageURL)
                    }
                
            })
            .padding(.horizontal)
                .navigationTitle("Staggered Gird")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            columns += 1
                        } label: {
                            Image(systemName: "plus")
                        }
                        
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            columns = max(columns - 1, 1)
                        } label: {
                            Image(systemName: "minus")
                        }
                        
                    }
                
                }
            //animation...
                .animation(.easeInOut, value: columns)
        }
        .onAppear {
            for index in 1...10 {
                posts.append(Post(imageURL: "product\(index)"))
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


//since we declared T as Identiable...
// So we need to pass Identiable conform collection/Array...

struct PostCardView: View {

    var post: Post
    var body: some View {
        Image(post.imageURL)
            .resizable()
            .aspectRatio( contentMode: .fit)
            .cornerRadius(10)
    }
    
}
