//
//  PhoneVerificationView.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/6/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase

struct PhoneVerificationView: View {
    
    @State var code = ""
    @Binding var show : Bool
    @Binding var ID: String
    @State var message = "" //error message
    @State var alertShowing = false //show alert yes/no
    @State var creation = false //has the account been created before
    @State var loading = false //whether the stuff happening is loading or not
    
    var body: some View {
        
        ZStack(alignment: .topLeading) {
            GeometryReader {_ in
                VStack(spacing: 5) {
                    Image("chatLogo")
                    Text("Verification Code").font(.largeTitle).fontWeight(.heavy).foregroundColor(.blue)
                    Text("Please enter the verification code sent to your device!")
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.top, 2)
                    
                    TextField("Verification Code", text: self.$code)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(Color("Color"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top, 16)
                    
                    
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
                            
                            let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.ID, verificationCode: self.code)
                            
                            //log in
                            Auth.auth().signIn(with: credential) { (res, err) in
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
                            Text("Verify").frame(width: UIScreen.main.bounds.width - 30, height: 50)
                    }.foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
            }
        }
        
            Button(action: {
                self.show.toggle()
            }) {
                Image(systemName: "chevron.left").font(.title)
                Text("Back")
            }.foregroundColor(.blue)
            
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
