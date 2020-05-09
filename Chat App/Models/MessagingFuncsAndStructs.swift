//
//  MessagingFuncsAndStructs.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/7/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import SDWebImageSwiftUI

//send message function -- saves messages to firestore
func sendMessage(user: String, uid: String, picURL: String, date: Date, message: String) {
    let db = Firestore.firestore()
    let currUID = Auth.auth().currentUser?.uid
    
    //get collection of users from firebase
    db.collection("users").document(uid).collection("recents").document(currUID!).getDocument { (snap, err) in
        if err != nil {
            print((err?.localizedDescription)!)
            //if there is no recent records
            setRecents(user: user, uid: uid, picURL: picURL, date: date, message: message)
            return
        }
        
        if !snap!.exists {
            setRecents(user: user, uid: uid, picURL: picURL, date: date, message: message)
        } else {
            updateRecents(uid: uid, lastMessage: message, date: date)
        }
    }
    updateDB(uid: uid, message: message, date: date)
    
}

//updates firebase to indicate a relation between two users
func setRecents(user: String, uid: String, picURL: String, date: Date, message: String) {
    let db = Firestore.firestore()
    let currUID = Auth.auth().currentUser?.uid
    let currName = UserDefaults.standard.value(forKey: "UserName") as! String
    let currPic = UserDefaults.standard.value(forKey: "picURL") as! String
    
    //relation to one user
    db.collection("users").document(uid).collection("recents").document(currUID!).setData(["name": currName, "picURL":currPic, "lastMessage":message, "date":date]) { (err) in
        if err != nil {
            print((err?.localizedDescription)!)
            return
        }
    }
    //relation to other user
    db.collection("users").document(currUID!).collection("recents").document(uid).setData(["name": user, "picURL":picURL, "lastMessage":message, "date":date]) { (err) in
        if err != nil {
            print((err?.localizedDescription)!)
            return
        }
    }
}

//updates view of recent chats (message/date change with new messages)
func updateRecents(uid: String, lastMessage: String, date: Date) {
    let db = Firestore.firestore()
    let currUID = Auth.auth().currentUser?.uid
    
    db.collection("users").document(uid).collection("recents").document(currUID!).updateData(["lastMessage":lastMessage, "date":date])
    
    db.collection("users").document(currUID!).collection("recents").document(uid).updateData(["lastMessage":lastMessage, "date":date])
}

//updates database in regards to messages (saves new messages)
func updateDB(uid: String, message: String, date: Date) {
    let db = Firestore.firestore()
    let currUID = Auth.auth().currentUser?.uid
    
    db.collection("messages").document(uid).collection(currUID!).document().setData(["message":message, "user":currUID!, "date":date]) { (err) in
        if err != nil {
            print((err?.localizedDescription)!)
            return
        }
    }
    
    db.collection("messages").document(currUID!).collection(uid).document().setData(["message":message, "user":currUID!, "date":date]) { (err) in
        if err != nil {
            print((err?.localizedDescription)!)
            return
        }
    }
}

//gets users and their information
class getUsers: ObservableObject {
    @Published var users = [User]()
    
    init() {
        let db = Firestore.firestore()
        
        db.collection("users").getDocuments{ (snap, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents {
                let id = i.documentID
                let name = i.get("name") as! String
                let picURL = i.get("picURL") as! String
                let info = i.get("info") as! String
                
                if id != UserDefaults.standard.value(forKey: "UID") as! String {
                    self.users.append(User(id: id, name: name, picURL: picURL, info: info))
                }
                
            }
        }
    }
}


//view of chats displayed (chats that user has already done in the past)
struct RecentContactsCellView: View {
    var url: String
    var name: String
    var time: String
    var date: String
    var lastMessage: String
    
    @Binding var dark: Bool //dark mode or light mode indicator
    
    var body: some View {
        HStack {
            AnimatedImage(url: URL(string: url)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
                
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(name).foregroundColor(self.dark ? Color.white : Color.black)
                        Text(lastMessage).foregroundColor(self.dark ? Color.white : Color.black)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 4) {
                        Text(date).foregroundColor(self.dark ? Color.white : Color.gray)
                        Text(time).foregroundColor(self.dark ? Color.white : Color.gray)
                    }
                }
                Divider()
            }
        }
    }
}

//structure for users
struct User: Identifiable {
    var id: String
    var name: String
    var picURL: String
    var info: String
}

//cell of a user (view), used for screen shown when creating new chat
struct UserCellView: View {
    var url: String
    var name: String
    var info: String
    
    var body: some View {
        HStack {
            //profile picture of user
            AnimatedImage(url: URL(string: url)!).resizable().renderingMode(.original).frame(width: 55, height: 55).clipShape(Circle())
                
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(name).foregroundColor(.gray) //name of user
                        Text(info).foregroundColor(.gray) //users info/description they set
                    }
                    Spacer()
                }
                Divider()
            }
        }
    }
}
