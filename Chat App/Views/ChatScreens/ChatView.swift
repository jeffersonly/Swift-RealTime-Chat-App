//
//  ChatView.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/7/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore

//Chat view, shows messages
struct ChatView: View {
    var name: String
    var picURL: String
    var id: String
    @Binding var chat: Bool
    @State var messages = [Message]()
    @State var text = ""
    @State var noMessages = false
    
    
    var body: some View {
        VStack {
            if messages.count == 0 {
                if self.noMessages {
                    Text("No Prior Messages!").foregroundColor(Color.black.opacity(0.5)).padding(.top)
                    Text("Be the one to kickstart the conversation!").foregroundColor(Color.black.opacity(0.5)).padding(.top)
                    Spacer()
                } else {
                    Spacer()
                    Indicator()
                    Spacer()
                }
                
            } else {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 8) {
                        ForEach(self.messages) { i in
                            HStack {
                                if i.user == UserDefaults.standard.value(forKey: "UID") as! String {
                                    Spacer()
                                    Text(i.message)
                                        .padding()
                                        .background(Color.blue)
                                        .clipShape(ChatBubble(myMessage: true))
                                        .foregroundColor(.white)
                                } else {
                                    Text(i.message)
                                        .padding()
                                        .background(Color.green)
                                        .clipShape(ChatBubble(myMessage: false))
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            
            HStack {
                TextField("Enter Message", text: self.$text).textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    sendMessage(user: self.name, uid: self.id, picURL: self.picURL, date: Date(), message: self.text)
                    self.text = ""
                }) {
                    Text("Send")
                }
            }
                .navigationBarTitle("\(name)", displayMode: .inline)
                .navigationBarItems(leading: Button(action: {
                    self.chat.toggle()
                }, label: {
                    Image(systemName: "arrow.left").resizable().frame(width: 20, height: 15)
                }))
        }.padding()
            .onAppear {
                self.getMessages()
        }
    }
    
    func getMessages() {
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        db.collection("messages").document(uid!).collection(self.id).order(by: "date", descending: false).addSnapshotListener { (snap, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                self.noMessages = true
                return
            }
            
            if snap!.isEmpty {
                self.noMessages = true
            }
            
            for i in snap!.documentChanges {
                if i.type == .added {
                    let id = i.document.documentID
                    let message = i.document.get("message") as! String
                    let user = i.document.get("user") as! String
                    
                    self.messages.append(Message(id: id, message: message, user: user))
                }
                
            }
        }
    }
}

//structure for message
struct Message: Identifiable {
    var id: String
    var message: String
    var user: String
}

//structure for chat message
struct ChatBubble: Shape {
    var myMessage: Bool
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight, myMessage ? .bottomLeft: .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        return Path(path.cgPath)
    }
}
