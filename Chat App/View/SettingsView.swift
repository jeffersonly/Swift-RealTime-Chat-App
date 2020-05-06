//
//  SettingsView.swift
//  Message App Final
//
//  Created by Sean Quach on 5/3/20.
//  Copyright © 2020 Jefferson and Sean. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @State var notificationsOn = true
    @State var soundOn = true
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Settings")
                    .foregroundColor(Color.white)
                    .font(.system(size: 40))
                    .offset(y: 0)
                NavigationView {
                    Color.black.edgesIgnoringSafeArea(.all)
                    Text("")
                        .navigationBarTitle("", displayMode: .inline)
            
                    
                    
                }
                // TODO replace text with user info

                Toggle("Notifications", isOn: $notificationsOn)
                    .offset(y: -450)
                    .foregroundColor(Color.white)
                    .padding()
                    
                Toggle("Sound", isOn: $soundOn)
                    .offset(y: -430)
                      .foregroundColor(Color.white)
                    .padding()
                Button("Reset Password", action: resetPassword)
                    .background(Color.white)
                    .foregroundColor(Color.black)
                    .border(Color.white, width: 1)
                    .font(.system(size: 30))
                    .offset(y: -80)

                Button(action: session.signOut) {
                    Text("Sign Out")
                }
                    .foregroundColor(Color.black)
                    .background(Color.white)
                    .border(Color.white, width: 1)
                    .font(.system(size: 30))
                    .offset(y: -50)
                
            }.onAppear(perform: getUser)
        }
    }
        
        
        
    
    
    func resetPassword() {
        
    }
    
    func logOut() {
        
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(SessionStore())
    }
}
