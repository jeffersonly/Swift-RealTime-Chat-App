//
//  HomeView.swift
//  Message App Final
//
//  Created by Sean Quach on 5/3/20.
//  Copyright © 2020 Jefferson and Sean. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State private var searchContent: String = ""
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        NavigationLink(destination: ProfileView()) {
                    
                                Image("profilePic")
                                    .renderingMode(.original)
                                    .resizable()
                                    .clipShape(Circle())
                                    .frame(width: 75.0, height: 75.0)
                                    .offset(x: -15)
                                
                      
                        }
                        .offset(x: 0)
                        .offset(y: 25)
                        Text("Chats")
                            .foregroundColor(Color.white)
                            .offset(y: 25)
                            .offset(x: -10)
                            .font(.system(size: 35))
                            .frame(width: 100, height: 50)
                        
                        
                        NavigationLink(destination: CreateChatView()) {
                            Text("+ Create Chat")
                                .padding(5)
                                .background(Color.white)
                                .foregroundColor(Color.black)
                                .border(Color.white, width: 1)
                                .font(.system(size: 20))
                                .cornerRadius(40)
                        }
                        .navigationBarTitle("Back")
                            
                            
                            
                            
                        .offset(x:0)
                        .offset(y: 20)
       
                        
                        
                    }
                    
                    
                    TextField("Search", text: $searchContent)
                        .offset(x: 25)
                        .background(Color.white)
                        .frame(width: 350, height: 25)
                        .cornerRadius(40)
                        .padding()
                    
                    List {
                        ContactItemView(name: "Kevin Nguyen")
                        ContactItemView(name: "Travis Le")
                        ContactItemView(name: "Tom Smith")
                        ContactItemView(name: "Anna Tran")
                        ContactItemView(name: "Brian Le")
                        ContactItemView(name: "Phil Tran")
                        ContactItemView(name: "Jenny Luu")
                        
                        
                        
                        
                        
                    }
                         .frame(width: 450, height: 600)
                    
                    
                    
                    
                }
                .offset(y: -18)
            }
            
        }
        
    }
    // TODO make the view transition to a new chat view
    func newChatViewTransition() {
        
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
