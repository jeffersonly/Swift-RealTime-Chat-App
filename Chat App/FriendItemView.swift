//
//  FriendItemView.swift
//  Message App Final
//
//  Created by Sean Quach on 5/3/20.
//  Copyright © 2020 Jefferson and Sean. All rights reserved.
//

import SwiftUI

// view for an item in a list of friends
struct FriendItemView: View {
    @State private var added = false
    var name: String
    var body: some View {
        HStack {
            ContactItemView(name: self.name)
                .offset(x: -30)
                .frame(width: 220, alignment: .leading)
            Button(action: {
                self.added = true
                
            }) {
                if(!added) {
                    Text("+ Add Friend")
                        .background(Color.white)
                        .foregroundColor(Color.black)
                        .border(Color.white, width: 1)
                        .font(.system(size: 20))
                        .cornerRadius(40)
                } else {
                    Text("Added!")
                        .background(Color.white)
                        .foregroundColor(Color.gray)
                        .border(Color.white, width: 1)
                        .font(.system(size: 20))
                        .cornerRadius(40)
                }
                } .disabled(added)
        }
    }
    
    init(name: String) {
        self.name = name
    }
    
    init() {
        self.name = ""
    }

}



struct FriendItemView_Previews: PreviewProvider {
    static var previews: some View {
        FriendItemView()
    }
}
