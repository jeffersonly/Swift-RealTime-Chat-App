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
    
    let currUID = Auth.auth().currentUser?.uid
    let currName = UserDefaults.standard.value(forKey: "UserName") as! String
    let currPic = UserDefaults.standard.value(forKey: "picURL") as! String
    
    @State var uid = UserDefaults.standard.value(forKey: "UserName") as! String
    @EnvironmentObject var data: MainObservable
    @State var show = false //whether or not chat view will be showing
    @State var chat = false
    @State var id = "" //identifies user
    @State var name = "" //name of user/username
    @State var picURL = "" //pictural url for profile
    
    @State var showSideMenu = false // state of the side menu
    @State var dark = false // state of dark mode
    
    var body: some View {
        
        ZStack {
            NavigationLink(destination: ChatView(name: self.name, picURL: self.picURL, id: self.id, chat: self.$chat, dark: self.$dark), isActive: self.$chat) {
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
                    //display recent conversations with other users
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 12) {
                            ForEach(data.recents.sorted(by: {$0.timeStamp > $1.timeStamp})) { i in
                                Button(action: {
                                    self.id = i.id
                                    self.name = i.name
                                    self.picURL = i.picURL
                                    self.chat.toggle()
                                }) {
                                    RecentContactsCellView(url: i.picURL, name: i.name, time: i.time, date: i.date, lastMessage: i.lastMessage, dark: self.$dark)
                                }
                            }
                        }.padding()
                            .offset(y:65)
                    }
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading:
                //menu
                Button(action: {
                    withAnimation(.default) {
                        self.showSideMenu.toggle()

                    }
                }, label: {
                    Image(systemName: "person.circle").resizable().frame(width: 30, height: 30).foregroundColor(self.dark ? Color.white : Color.black)
                })
                //start chat with other users
                , trailing:
                Button(action: {
                    self.show.toggle()
                }, label: {
                    Image(systemName: "square.and.pencil").resizable().frame(width: 25, height: 25).foregroundColor(self.dark ? Color.white : Color.black)
                })
            ).background((self.dark ? Color.black : Color.white).edgesIgnoringSafeArea(.all))
            
            //this stack is messing with the view of the home page
            HStack {
                SideMenuView(dark: self.$dark, show: self.$showSideMenu)
                    .preferredColorScheme(self.dark ? .dark : .light)
                    .offset(x: self.showSideMenu ? 0 : -UIScreen.main.bounds.width / 1.5)
              
                Spacer(minLength: 0)
            }
            .background(Color.primary.opacity(self.showSideMenu ? (self.dark ? 0.05 : 0.2) : 0).edgesIgnoringSafeArea(.all))
        }
        .background((self.dark ? Color.black : Color.white).edgesIgnoringSafeArea(.all))
        .sheet(isPresented: self.$show) {
            NewChatView(name: self.$name, id: self.$id, picURL: self.$picURL, show: self.$show, chat: self.$chat, dark: self.$dark)
        }
        
    }
}
