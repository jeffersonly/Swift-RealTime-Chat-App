//
//  AuthView.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/7/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn
import SDWebImageSwiftUI

struct AuthView: View {

    @State var username = "" //email or username of user
    @State var password = "" //user's password
    @State var show = false
    @State var message = "" //error message
    @State var alertShowing = false //show alert yes/no
    @State var creation = false //has the account been created before
    @State var loading = false //whether the stuff happening is loading or not

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image("chatLogo").resizable().frame(width: 200, height: 200)
                Text("Messager").font(.largeTitle).fontWeight(.heavy).foregroundColor(.blue)
                Text("Login to your account!")
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(.top, 2)
                
                TextField("Email/Username", text: self.$username)
                    .padding()
                    .background(Color("Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                SecureField("Password", text: self.$password)
                    .padding()
                    .background(Color("Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))

                //sign in button
                //if loading... render loading animation stuff
                if self.loading {
                    HStack {
                        Spacer()
                        Indicator()
                        Spacer()
                    }
                } else {
                    Button(action: {
                        self.loading.toggle()
                        
                        //log in
                        Auth.auth().signIn(withEmail: self.username, password: self.password) { (res, err) in
                            if err != nil {
                                self.message = (err?.localizedDescription)!
                                self.alertShowing.toggle()
                                self.loading.toggle()
                                return
                            }
                            
                            //check if user exists already or not
                            checkUser { (exists, user, uid, picURL) in
                                if exists {
                                    UserDefaults.standard.set(true, forKey: "status")
                                    UserDefaults.standard.set(user, forKey: "UserName")
                                    UserDefaults.standard.set(uid, forKey: "UID")
                                    UserDefaults.standard.set(picURL, forKey: "picURL")
                                    NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                                } else {
                                    self.loading.toggle()
                                    self.creation.toggle()
                                }
                            }
                        }
                        
                    }) {
                        Text("Login").frame(width: UIScreen.main.bounds.width - 30, height: 50)
                    }
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                
                NavigationLink(destination: CustomRegisterView()) {
                    HStack {
                        
                        Text("Create an account using Email").foregroundColor(.blue)
                        //mail icon not appearing for some reason...
                        Image(systemName: "envelope").resizable().frame(width: 25, height: 25)
                    }
                }
                
                Text("Or").fontWeight(.heavy).foregroundColor(.blue)
                
                NavigationLink(destination: PhoneRegisterView()) {
                    HStack {
                        Text("Login using Phone Number").foregroundColor(.blue)
                        Image(systemName: "phone").resizable().frame(width: 25, height: 25)
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
            }
            .padding()
            .alert(isPresented: $alertShowing) {
                Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("Ok")))
            }
            .sheet(isPresented: self.$creation) {
                CreateAccount(show: self.$creation)
            }
        }
    }
}
