//
//  HomeView.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/6/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//
import SwiftUI
import Firebase
import FirebaseFirestore
import GoogleSignIn
import SDWebImageSwiftUI

struct HomeView: View {
    
    @State var uid = UserDefaults.standard.value(forKey: "UserName") as! String
    @EnvironmentObject var data: MainObservable
    @State var show = false //whether or not chat view will be showing
    @State var chat = false
    @State var id = "" //identifies user
    @State var name = "" //name of user/username
    @State var picURL = "" //pictural url for profile
    
    @State var showSideMenu = false
    @State var dark = false
    
    
    var body: some View {
        
        ZStack {
            NavigationLink(destination: ChatView(name: self.name, picURL: self.picURL, id: self.id, chat: self.$chat), isActive: self.$chat) {
                Text("")
            }
            
            VStack {
                if self.data.recents.count == 0 {
                    if self.data.noRecents {
                        Text("No Chat History")
                    } else {
                        Indicator()
                    }
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(data.recents.sorted(by: {$0.timeStamp > $1.timeStamp})) { i in
                                
                                Button(action: {
                                    self.id = i.id
                                    self.name = i.name
                                    self.picURL = i.picURL
                                    self.chat.toggle()
                                }) {
                                    RecentContactsCellView(url: i.picURL, name: i.name, time: i.time, date: i.date, lastMessage: i.lastMessage)
                                }
                                
                            }
                            
                        }.padding()
                    }
                }
            }
            .navigationBarTitle("Home", displayMode: .inline)
            .navigationBarItems(leading:
                
                Button(action: {
                    withAnimation(.default) {
                        self.showSideMenu.toggle()
                        print("menu toggle: ", self.showSideMenu)
                    }
                }, label: {
                    Text("Menu")
                })
                
                , trailing:
                Button(action: {
                    self.show.toggle()
                }, label: {
                    Image(systemName: "square.and.pencil").resizable().frame(width: 25, height: 25)
                })
            )
            
            HStack {
                SideMenuView(dark: self.$dark, show: self.$showSideMenu, name: self.$id)
                    .preferredColorScheme(self.dark ? .dark : .light)
                    .offset(x: self.showSideMenu ? 0 : -UIScreen.main.bounds.width / 1.5)
                
                Spacer(minLength: 0)
            }
            .background(Color.primary.opacity(self.showSideMenu ? (self.dark ? 0.05 : 0.2) : 0).edgesIgnoringSafeArea(.all))
            
            
            
        }
            
            
        .sheet(isPresented: self.$show) {
            NewChatView(name: self.$name, id: self.$id, picURL: self.$picURL, show: self.$show, chat: self.$chat)
            

        }
    }
}
