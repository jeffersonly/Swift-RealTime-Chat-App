//
//  PhoneRegisterView.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/6/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct PhoneRegisterView: View {
    
    @State var number = "" //phone number
    @State var countryCode = "" //country code number +1, +2, etc.
    @State var show = false
    @State var message = "" //error message
    @State var alertShowing = false //show alert yes/no
    @State var ID = ""
    
    var body: some View {
        VStack(spacing: 20) {
            //Google sign in
//            GoogleSignView()
//            .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
//            .frame(height: 50)
//            .foregroundColor(.white)
//            .font(.system(size: 14, weight: .bold))
//            .cornerRadius(5)
            
            Image("chatLogo")
            Text("Verify Your Number").font(.largeTitle).fontWeight(.heavy).foregroundColor(.blue)
            Text("Please enter your phone number to verify your account!")
                .multilineTextAlignment(.center)
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 2)
            
            HStack {
                TextField("+1", text: $countryCode)
                    .keyboardType(.numberPad)
                    .frame(width: 45)
                    .padding()
                    .background(Color("Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                TextField("Number", text: $number)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color("Color"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }.padding(.top, 16)
            
            //pass stuff like props to different view
            NavigationLink(destination: PhoneVerificationView(show: $show, ID: $ID), isActive: $show) {
                Button(action: {
                    
                    //Remove when testing with a real phone
                    //Auth.auth().settings?.isAppVerificationDisabledForTesting = true
                    
                    PhoneAuthProvider.provider().verifyPhoneNumber("+"+self.countryCode+self.number, uiDelegate: nil) { (ID, err) in
                        if err != nil {
                            self.message = (err?.localizedDescription)!
                            self.alertShowing.toggle()
                            return
                        }
                        self.ID = ID!
                        self.show.toggle()
                    }
                }) {
                    Text("Send").frame(width: UIScreen.main.bounds.width - 30, height: 50)
                }
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }
        .padding()
        .alert(isPresented: $alertShowing) {
            Alert(title: Text("Error"), message: Text(self.message), dismissButton: .default(Text("Ok")))
        }
    }
}
