//
//  ProfilePage.swift
//  Event
//
//  Created by Innocrux on 28/04/23.
//

import SwiftUI

struct ProfilePage: View {
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 0) {
                    Text("My Profile")
                        .font(.system(size:  28).bold())
                       .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15) {
                        Image("Profile_image")
                            .resizable()
                            .aspectRatio( contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom, -30)
                        
                        Text("Jack")
                            .font(.system(size: 16).bold())
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10) {
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("27 V Ponni Nagar , Veeraganur  Salem")
                                .font(.system(size: 15).bold())
                                .fontWeight(.semibold)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.horizontal, .bottom])
                    .background(
                        Color.white
                            .cornerRadius(12)
                    )
                    
                }
                .padding()
                .padding(.top, 40)
                
                //Custom navigation Link...
                
                customNavigationLink(tittle: "Edit profile" ) {
                    Text("")
                        .navigationTitle("Edit profile")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            Color.gray.opacity(0.07).ignoresSafeArea()
                        )
                }
                customNavigationLink(tittle: "Shopping Address" ) {
                    Text("")
                        .navigationTitle("Shopping Address")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            Color.gray.opacity(0.07).ignoresSafeArea()
                        )
                }
                customNavigationLink(tittle: "Order History" ) {
                    Text("")
                        .navigationTitle("Order History")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            Color.gray.opacity(0.07).ignoresSafeArea()
                        )
                }
                customNavigationLink(tittle: "Cards" ) {
                    Text("")
                        .navigationTitle("Cards")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            Color.gray.opacity(0.07).ignoresSafeArea()
                        )
                }
                customNavigationLink(tittle: "Notifications" ) {
                    Text("")
                        .navigationTitle("Notifications")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(
                            Color.gray.opacity(0.07).ignoresSafeArea()
                        )
                }
                
            }
            .navigationBarBackButtonHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.gray.opacity(0.07).ignoresSafeArea()
            )
        }
    }
    
    @ViewBuilder
    func customNavigationLink<Detail: View>(tittle: String,
                                            @ViewBuilder content:
                                            @escaping () -> Detail
    ) -> some View {
        NavigationLink {
            content()
        } label: {
            HStack {
                Text(tittle)
                    .font(.system(size:  17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background(
                Color.white
                    .cornerRadius(12)
            )
            .padding(.horizontal)
            .padding(.top, 10)
        }

    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
