//
//  CheckUserModel.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/6/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

//method to check if user exists or not
func checkUser(completion: @escaping (Bool, String, String, String) -> Void) {
    let db = Firestore.firestore()
    
    db.collection("users").getDocuments { (snap, err) in
        if err != nil {
            print((err?.localizedDescription)!)
            return
        }
        
        for i in snap!.documents {
            if i.documentID == Auth.auth().currentUser?.uid {
                completion(true, i.get("name") as! String, i.documentID, i.get("picURL") as! String)
                return
            }
        }
        completion(false, "", "", "")
    }
}
