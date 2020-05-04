//
//  AddFriendsView.swift
//  Message App Final
//
//  Created by Sean Quach on 5/3/20.
//  Copyright © 2020 Jefferson and Sean. All rights reserved.
//

import SwiftUI

struct AddFriendsView: View {
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
                    
                    Text("Add Friends")
                        .foregroundColor(Color.white)
                        .offset(y: 0)
                        .offset(x: 0)
                        .font(.system(size: 50))
                    
                }
                TextField("Search", text: self.$searchContent)
                    .background(Color.white)
                    .frame(width: 350, height: 25)
                    .cornerRadius(40)
                    .offset(x: 0)
                    .offset(y: 0)
                    .padding()
                
                FriendItemView()
                FriendItemView()
                FriendItemView()
                FriendItemView()
                FriendItemView()
                FriendItemView()
                FriendItemView()
                
                
            }
            
        }
    }
    
    
    func addFriend() {
        
    }
}

struct AddFriendsView_Previews: PreviewProvider {
    static var previews: some View {
        AddFriendsView()
    }
}
