//
//  ContentView.swift
//  Chat App
//
//  Created by Jefferson Ly on 4/26/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseFirestore
import FirebaseStorage

struct ContentView: View {

    //check if user is logged in or not
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    
    var body: some View {
        VStack {
            if status {
                NavigationView {
                    HomeView().environmentObject(MainObservable())
                }
            } else {
                NavigationView {
                    AuthView()
                }
            }
            
        }.onAppear {
            //event listener for the status of the user
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"), object: nil, queue: .main) { (_) in
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



class MainObservable: ObservableObject {
    @Published var recents = [Recent]()
    @Published var noRecents = false
    
    init() {
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        if(uid != nil) {
            db.collection("users").document(uid!).collection("recents").order(by: "date", descending: true).addSnapshotListener { (snap, err) in
                
                if err != nil {
                    print((err?.localizedDescription)!)
                    self.noRecents = true
                    return
                }
                
                if snap!.isEmpty {
                    self.noRecents = true
                }
                
                for i in snap!.documentChanges {
                    
                    if i.type == .added {
                        let id = i.document.documentID
                        let name = i.document.get("name") as! String
                        let picURL = i.document.get("picURL") as! String
                        let lastMessage = i.document.get("lastMessage") as! String
                        let dateStamp = i.document.get("date") as! Timestamp
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yy"
                        let date = dateFormatter.string(from: dateStamp.dateValue())
                        
                        dateFormatter.dateFormat = "hh:mm a"
                        let time = dateFormatter.string(from: dateStamp.dateValue())
                        
                        self.recents.append(Recent(id: id, name: name, picURL: picURL, lastMessage: lastMessage, time: time, date: date, timeStamp: dateStamp.dateValue()))
                    }
                    
                    if i.type == .modified {
                        let id = i.document.documentID
                        let lastMessage = i.document.get("lastMessage") as! String
                        let dateStamp = i.document.get("date") as! Timestamp
                        
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MM/dd/yy"
                        let date = dateFormatter.string(from: dateStamp.dateValue())
                        
                        dateFormatter.dateFormat = "hh:mm a"
                        let time = dateFormatter.string(from: dateStamp.dateValue())
                        
                        for j in 0..<self.recents.count {
                            if self.recents[j].id == id {
                                self.recents[j].lastMessage = lastMessage
                                self.recents[j].time = time
                                self.recents[j].date = date
                                self.recents[j].timeStamp = dateStamp.dateValue()
                            }
                        }
                    }
                    
                }
                
            }
        }
    }
}

//Structure for recent messages
struct Recent: Identifiable {
    var id: String
    var name: String
    var picURL: String
    var lastMessage: String
    var time: String
    var date: String
    var timeStamp: Date
}
