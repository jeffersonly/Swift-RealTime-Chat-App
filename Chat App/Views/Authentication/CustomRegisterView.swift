//
//  CustomRegisterView.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/7/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn
import SDWebImageSwiftUI

struct CustomRegisterView: View {

    @State var username = "" //email or username of user
    @State var password = "" //user's password
    @State var confirmPassword = ""
    @State var show = false
    @State var message = "" //error message
    @State var alertShowing = false //show alert yes/no
    @State var creation = false //has the account been created before
    @State var loading = false //whether the stuff happening is loading or not

    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                Image("chatLogo").resizable().frame(width: 200, height: 200)
                Text("Register Here!").font(.largeTitle).fontWeight(.heavy).foregroundColor(.blue)
                Text("Please fill in the fields below!")
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
                SecureField("Confirm Password", text: self.$confirmPassword)
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
                        
                        //register
                        if self.password == self.confirmPassword {
                            
                            Auth.auth().createUser(withEmail: self.username, password: self.password) { (res, err) in
                                //if error, display error message
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
                            
                        } else {
                            //if passwords dont match, display error
                            self.message = "Passwords do not match"
                            self.alertShowing.toggle()
                            self.loading.toggle()
                            return
                        }
                        
                    }) {
                        Text("Register").frame(width: UIScreen.main.bounds.width - 30, height: 50)
                    }
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                
                Text("Or").fontWeight(.heavy).foregroundColor(.blue)
                
                NavigationLink(destination: PhoneRegisterView()) {
                    HStack {
                        Text("Login using Phone Number")
                        Image(systemName: "phone").resizable().frame(width: 25, height: 25)
                    }
                }
            }
            .padding()
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .alert(isPresented: $alertShowing) {
                Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("Ok")))
            }
            .sheet(isPresented: self.$creation) {
                CreateAccount(show: self.$creation)
            }
        }
    }
}
