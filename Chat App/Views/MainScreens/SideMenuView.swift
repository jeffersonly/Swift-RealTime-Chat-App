//
//  SideMenuView.swift
//  Chat App
//
//  Created by Sean Quach on 5/8/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import GoogleSignIn

struct SideMenuView : View {
    
    let currUID = Auth.auth().currentUser?.uid // current user id
    let currName = UserDefaults.standard.value(forKey: "UserName") as! String // current user name
    let currPic = UserDefaults.standard.value(forKey: "picURL") as! String // current profile pic
    
    @Binding var dark : Bool // binding variable for dark mode
    @Binding var show: Bool // binding variable for show
    
    var body: some View {
        
        VStack {
    
            HStack {
                Button(action: {
                    withAnimation(.default) {
                        self.show.toggle()
                    }
                }) {
                    Text("")
                    
                }
                Spacer()
                
            }
            .offset(x: -20, y: 30)
            .padding(.top)
            .padding(.bottom, 25)
            
            UserCellView(url:currPic, name: currName, info: "")
            .padding(.top, 25)
            
            // dark mode text and toggle
            HStack(spacing: 22) {
                
                Text("Dark Mode")
                
                
                Spacer()
                
                // toggles dark mode or light mode
                Button(action: {
                    self.dark.toggle()
                    UIApplication.shared.windows.first?.rootViewController?.view.overrideUserInterfaceStyle = self.dark ? .dark : .light
                    print("dark mode: ", self.dark)
                }) {
                    
                    Toggle("toggle",isOn: self.$dark)
                        .labelsHidden()
                    
                }
                
            }
            .padding(.top, 25)
            .frame(height: UIScreen.main.bounds.height / 1.5)
            .offset(y: -225)
            
            Group {
                if(!self.dark) {
                    // navigation to my profile view
                    NavigationLink(destination: MyProfileView()) {
                        Text("My Profile")
                    }
                    .offset(x: -80, y:-450)
                }
                
    
                // button to sign out
              Button(action: {
                    UserDefaults.standard.set("", forKey: "UserName")
                    UserDefaults.standard.set("", forKey: "UID")
                    UserDefaults.standard.set("", forKey: "picURL")
                    
                    try! Auth.auth().signOut()
                    //GIDSignIn.sharedInstance()?.signOut()
                    
                    UserDefaults.standard.set(false, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                }, label: {
                    Text("Sign Out")
                })
                .offset(x: -85, y: -100)
            }
            
        }
        .padding(.top, 25)
        .foregroundColor(.primary)
        .padding(.horizontal, 20)
        .background((self.dark ? Color.black : Color.white).edgesIgnoringSafeArea(.all))
        .overlay(Rectangle().stroke(Color.primary.opacity(0.2), lineWidth: 2).shadow(radius: 3).edgesIgnoringSafeArea(.all))
        .frame(width: UIScreen.main.bounds.width / 1.5)
    }
}
