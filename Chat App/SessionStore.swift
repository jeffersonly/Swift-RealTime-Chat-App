//
//  SessionStore.swift
//  Chat App
//
//  Created by Jefferson Ly on 4/26/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase
import Combine
import GoogleSignIn

class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? {didSet {self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.session = User(uid: user.uid, name: user.displayName, email: user.email, profilePictureURL: user.photoURL)
            } else {
                self.session = nil
            }
        })
    }
    
    func signUp(email: String, name: String, password: String, image: UIImage, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("User Created!")
                
                self.uploadProfileImage(image) { url in
                    if url != nil {
                        let setChanges = Auth.auth().currentUser?.createProfileChangeRequest()
                        setChanges?.displayName = name
                        setChanges?.photoURL = url
                        setChanges?.commitChanges { (error) in
                            if error == nil {
                                print("User display name changed!")
                                self.saveProfile(username: name, profileImageURL: url!) { success in
                                    if success {
                                        print("Successfully stored profile picture")
                                    }
                                }
                            }
                        }
                    } else {
                        //error unable to upload profile image
                    }
                    
                }
            }
        }
    }
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping((_ url:URL?) -> ())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                //success
                storageRef.downloadURL { url, error in
                    completion(url)
                    // success!
                }
            } else {
                //fail
                completion(nil)
            }
        }
    }
    
    func saveProfile(username: String, profileImageURL: URL, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        let userObject = [
            "username": username,
            "photoURL": profileImageURL.absoluteString
        ] as [String:Any]
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
    
    func signIn(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance()?.signOut()
            self.session = nil
        } catch {
            print("Error signing out")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}

struct User {
    var uid: String
    var name: String?
    var email: String?
    var profilePictureURL: URL?
    init (uid: String, name: String?, email: String?, profilePictureURL: URL?) {
        self.uid = uid
        self.name = name
        self.email = email
        self.profilePictureURL = profilePictureURL
    }
}
