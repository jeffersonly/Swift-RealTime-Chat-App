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
    
    @ObservedObject var data = getUsers()
    @Binding var name: String
    @Binding var id: String
    @Binding var picURL: String
    @Binding var show: Bool
    @Binding var chat: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            if self.data.users.count == 0 {
                Indicator()
            } else {
                Text("Start a conversation!").font(.title).foregroundColor(Color.black.opacity(0.5))
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
        }.padding()
    }
}
