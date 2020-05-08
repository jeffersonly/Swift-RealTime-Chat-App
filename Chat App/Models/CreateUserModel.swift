//
//  CreateUserModel.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/6/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

func CreateUser(name: String, info: String, imageData: Data, completion: @escaping (Bool) -> Void) {
    //firestore
    let db = Firestore.firestore()
    let storage = Storage.storage().reference()
    
    //get current users id
    let uid = Auth.auth().currentUser?.uid
    
    //store data into firestore (image, uid, name, info)
    storage.child("profilePictures").child(uid!).putData(imageData, metadata: nil) { (_, err) in
        if err != nil {
            print((err?.localizedDescription)!)
            return
        }
        storage.child("profilePictures").child(uid!).downloadURL { (url, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            db.collection("users").document(uid!).setData(["name":name, "info":info, "picURL":"\(url!)", "uid":uid!]) { (err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                
                completion(true)
                
                UserDefaults.standard.set(true, forKey: "status")
                UserDefaults.standard.set(name, forKey: "UserName")
                UserDefaults.standard.set(uid, forKey: "UID")
                UserDefaults.standard.set("\(url!)", forKey: "picURL")
                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                
            }
        }
    }
}
