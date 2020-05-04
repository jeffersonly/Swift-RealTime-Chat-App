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
    var body: some View {
                HStack {
                   ContactItemView()
                       .offset(x: -30)
                       Button("+ Add Friend", action: addFriend)
                           .background(Color.white)
                           .foregroundColor(Color.black)
                           .border(Color.white, width: 1)
                           .font(.system(size: 20))
                       .cornerRadius(40)
                   }
    }
    // TODO add friend
    func addFriend() {
        
    }
}



struct FriendItemView_Previews: PreviewProvider {
    static var previews: some View {
        FriendItemView()
    }
}
