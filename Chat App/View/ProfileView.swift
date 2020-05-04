//
//  ProfileView.swift
//  Message App Final
//
//  Created by Sean Quach on 5/2/20.
//  Copyright © 2020 Jefferson and Sean. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

struct ProfileView: View {
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listen()
    }
    
    // TODO
    // constant to get the person's name
    // constant to get person's username
    // constant to get person's email
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Profile")
                    .foregroundColor(Color.white)
                    .font(.system(size: 40))
                NavigationView {
                    Color.black.edgesIgnoringSafeArea(.all)
                    Text("").navigationBarTitle("Profile", displayMode: .inline)
                }
                // TODO replace text with user info
                Text("Name: \(session.session!.name ?? "user")")
                    .offset(y: -250)
                    .foregroundColor(Color.white)
                    .font(.system(size: 30))
                
//                Image("\(session.session!.profilePictureURL?.absoluteString ?? "profilePic")")
//                    .resizable()
//                    .frame(width: 250.0, height: 250.0)
//                    .clipShape(Circle())
//                    .shadow(radius: CGFloat(10))
//                    .offset(y: CGFloat(-250))
                RemoteImage(url: session.session!.profilePictureURL!.absoluteString)
                
                // TODO replace text with current user's email
                Text("Email: \(session.session!.email ?? "user@gmail.com")")
                    .foregroundColor(Color.white)
                    .offset(y: CGFloat(-100))
                .font(.system(size: 30))
                // TODO replace text with current user's username
    //            Text("Username: ")
    //                .foregroundColor(Color.white)
    //                .offset(y: -50)
            }.onAppear(perform: getUser)
        }
    }
}




struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(SessionStore())
    }
}
