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
        ZStack(alignment: .topLeading) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        
                    }) {
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
                        .font(.system(size: 50))
                    Button("+ New Chat", action: newChatViewTransition)
                        .font(.system(size: 25))
                        .foregroundColor(Color.black)
                        .border(Color.white, width: 2)
                        .background(Color.white)
                        .cornerRadius(40)
                        .offset(x: 0)
                        .offset(y: 25)
                    
                }
                TextField("Search", text: $searchContent)
                    .offset(x: 25)
                    .background(Color.white)
                    .frame(width: 350, height: 25)
                    .cornerRadius(40)
                    .padding()
                
                List {
                    ContactItemView()
                    ContactItemView()
                    ContactItemView()
                    ContactItemView()
                    ContactItemView()
                    ContactItemView()
                    ContactItemView()
                    ContactItemView()
                    
                    
                    
                }
                
                
                
                
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
