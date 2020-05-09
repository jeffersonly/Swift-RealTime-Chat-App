//
//  NewChatView.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/7/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import SDWebImageSwiftUI

//view for creating a new conversation with other users
struct NewChatView: View {
    
    @ObservedObject var data = getUsers() //get all general users from db
    @Binding var name: String
    @Binding var id: String
    @Binding var picURL: String
    @Binding var show: Bool
    @Binding var chat: Bool
    @State var text = "" //text for search bar
    
    var body: some View {
        VStack(alignment: .leading) {
            if self.data.users.count == 0 {
                Indicator()
            } else {
                Text("Start a conversation!").font(.title).foregroundColor(Color.black.opacity(0.5))
                
                VStack() {
                    HStack {
                        TextField("Search for user", text: self.$text)
                        if self.text != "" {
                            Button(action: {
                                self.text = ""
                            }) {
                                Text("Cancel")
                            }.foregroundColor(.black)
                        }
                    }.padding()
                    .background(Color("Color"))
                    
                    if self.text != "" {
                        //if search can't find any matching users
                        //filters data of all users and finds matching results
                        if self.data.users.filter({$0.name.lowercased().contains(self.text.lowercased())}).count == 0{
                            Text("No Results Found").foregroundColor(Color.black.opacity(0.5)).padding()
                        } else {
                            //if search finds matching users, display them
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack(spacing: 12) {
                                    ForEach(self.data.users.filter({$0.name.lowercased().contains(self.text.lowercased())})) { i in
                                        Button(action: {
                                            self.id = i.id
                                            self.name = i.name
                                            self.picURL = i.picURL
                                            self.show.toggle()
                                            self.chat.toggle()
                                        }) {
                                            UserCellView(url: i.picURL, name: i.name, info: i.info)
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        //Scroll view, contains all different users from database and displays them
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 12) {
                                ForEach(data.users) { i in
                                    Button(action: {
                                        self.id = i.id
                                        self.name = i.name
                                        self.picURL = i.picURL
                                        self.show.toggle()
                                        self.chat.toggle()
                                    }) {
                                        UserCellView(url: i.picURL, name: i.name, info: i.info)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }.padding()
    }
}
