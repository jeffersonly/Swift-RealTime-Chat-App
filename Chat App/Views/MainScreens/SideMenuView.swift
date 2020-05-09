//
//  SideMenuView.swift
//  Chat App
//
//  Created by Sean Quach on 5/8/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI

struct SideMenuView : View {
    
    @Binding var dark : Bool
    @Binding var show: Bool
    @Binding var name: String
    
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
            
            Image("profilePic")
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
            
            VStack(spacing: 12) {
                Text(self.name)
                

            }
            .padding(.top, 25)
            
            HStack(spacing: 22) {
                
                Text("Dark Mode")
                
                
                Spacer()
                
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
                Button(action: {
                    
                }) {
                    HStack(spacing: 22) {
                        Text("My Profile")
                        
                    }
                }
                .offset(x: -80, y:-450)
                Button(action: {
                    
                }) {
                    HStack(spacing: 22) {
                        Text("Contacts")
                        
                    }
                }
                .offset(x: -83, y:-400)
                
                Button(action: {
                    
                }) {
                    HStack(spacing: 22) {
                        Text("Settings")
                        
                    }
                }
                .offset(x: -85, y:-350)
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
