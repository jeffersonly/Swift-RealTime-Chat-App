//
//  CreateChatView.swift
//  Message App Final
//
//  Created by Sean Quach on 5/3/20.
//  Copyright © 2020 Jefferson and Sean. All rights reserved.
//

import SwiftUI

struct CreateChatView: View {
    
    @State private var searchContent: String = ""
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                NavigationView {
                    Color.black.edgesIgnoringSafeArea(.all)
                    Text("")
                        .navigationBarTitle("", displayMode: .inline)
                    
                    
                    
                }
                .offset(y: -300)
                
                HStack {
                    
                    Text("Create a Chat")
                        .foregroundColor(Color.white)
                        .offset(y: -200)
                        .offset(x: 0)
                        .font(.system(size: 50))
                    
                }
                TextField("Search", text: self.$searchContent)
                    .background(Color.white)
                    .frame(width: 350, height: 25)
                    .cornerRadius(40)
                    .offset(x: 0)
                    .offset(y: -200)
                    .padding()
                
                
                
                FriendItemView(name: "Kevin Nguyen")
                FriendItemView(name: "Travis Le")
                FriendItemView(name: "Tom Smith")
                FriendItemView(name: "Anna Tran")
                
                
                
            }
            
        }
    }
    
}


struct CreateChatView_Previews: PreviewProvider {
    static var previews: some View {
        CreateChatView()
    }
}
