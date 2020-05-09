//
//  MyProfileView.swift
//  Chat App
//
//  Created by Sean Quach on 5/8/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase

struct MyProfileView: View {
    let currName = UserDefaults.standard.value(forKey: "UserName") as! String
    let currPic = UserDefaults.standard.value(forKey: "picURL") as! String
    let currUserPic = Auth.auth().currentUser?.photoURL

    
    var body: some View {
        
        VStack {
            // header displaying my profile
            Text("My Profile")
                .font(.system(size: 30))
            
            // displays user profile pic and name
                UserCellView(url: currPic, name: currName, info: "")
                    .frame(width: 300, height: 300)
        }
    }
}



struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
