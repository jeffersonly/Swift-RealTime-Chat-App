//
//  ProfileView.swift
//  Message App Final
//
//  Created by Sean Quach on 5/2/20.
//  Copyright © 2020 Jefferson and Sean. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
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
            Text("")
                .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarHidden(false)


        }
            // TODO replace text with user info
            Text("Kevin Nguyen")
                .offset(y: -250)
                .foregroundColor(Color.white)
                .font(.system(size: 40))
            
            Image("profilePic")
            .resizable()
                .frame(width: 250.0, height: 250.0)
            .clipShape(Circle())
            .shadow(radius: 10)
                .offset(y: -250)
            
            // TODO replace text with current user's email
            Text("Email: knguyen18@gmail.com")
                .foregroundColor(Color.white)
                .offset(y: -100)
            // TODO replace text with current user's username
            Text("Username: knguyen18")
                .foregroundColor(Color.white)
                .offset(y: -50)
            
 
        }
        
        }
      


    }
    
    
}




struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
