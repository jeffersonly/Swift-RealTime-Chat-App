//
//  ContactView.swift
//  Message App Final
//
//  Created by Sean Quach on 5/3/20.
//  Copyright © 2020 Jefferson and Sean. All rights reserved.
//

import SwiftUI

struct ContactView: View {
    @State var notificationsOn = true
    var name: String
    var body: some View {
        
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Contact")
                    .foregroundColor(Color.white)
                    .font(.system(size: 40))
                    .offset(y: -50)
                NavigationView {
                    Color.black.edgesIgnoringSafeArea(.all)
                    Text("")
                        .navigationBarTitle("Profile", displayMode: .inline)
                    
                    
                }
                // TODO replace text with user info
                Text(self.name)
                    .offset(y: -165)
                    .foregroundColor(Color.white)
                    .font(.system(size: 40))
                    .frame(width: 400.0, height: 50.0)
                
                Image("profilePic")
                    .resizable()
                    .frame(width: 250.0, height: 250.0)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .offset(y: -175)
                Text("Notifications")
                    .foregroundColor(Color.white)
                    .font(.system(size: 30))
                    .offset(y: -150)
                Toggle("Notifications", isOn: $notificationsOn)
                    .labelsHidden()
                    .offset(y: -145)
                Button("Block User", action: blockUser)
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .border(Color.white, width: 1)
                    .cornerRadius(35)
                    .font(.system(size: 30))
                    .offset(y: -80)
                
                Button("Delete Chat", action: deleteChat)
                    
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .border(Color.white, width: 1)
                    .cornerRadius(35)
                    .font(.system(size: 30))
                    .offset(y: -50)
                
                
                
            }
            
        }
        
        
        
    }
    
    init() {
        self.name = ""
    }
    
    init(name: String) {
        self.name = name
    }
    
    func blockUser() {
        
    }
    
    func deleteChat() {
        
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
