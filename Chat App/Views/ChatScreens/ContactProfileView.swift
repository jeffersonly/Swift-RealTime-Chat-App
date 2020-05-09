//
//  ContactProfileView.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/7/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import SDWebImageSwiftUI

//profile view of a contact of the current user (other users profile from chat view)

struct ContactProfileView: View {
    var name: String
    var picURL: String
    var id: String
    @State var errMessage = "" //error message
    @State var alertShowing = false //show alert yes/no
    @Binding var dark : Bool
    
    var body: some View {
        ZStack {
            self.dark ? Color.black.edgesIgnoringSafeArea(.all) : Color.white.edgesIgnoringSafeArea(.all)
            VStack {
                AnimatedImage(url: URL(string: picURL)!).resizable().renderingMode(.original).frame(width: 200, height: 200).clipShape(Circle())
                Text("\(name)").fontWeight(.heavy)
                    .foregroundColor(self.dark ? Color.white : Color.black)
                    .font(.system(size: 32))
                Spacer()
                Button(action: {
                    self.errMessage = "Sorry! This function is not yet available!"
                    self.alertShowing.toggle()
                }) {
                    HStack {
                        Text("Mute Notifications")
                    }
                }
                Spacer()
                Button(action: {
                    self.errMessage = "Sorry! This function is not yet available!"
                    self.alertShowing.toggle()
                }) {
                    HStack {
                        Text("Block User")
                    }
                }
                Spacer()
                Button(action: {
                    self.errMessage = "Sorry! This function is not yet available!"
                    self.alertShowing.toggle()
                }) {
                    HStack {
                        Image(systemName: "trash").resizable().frame(width: 22, height: 30)
                        Text("Delete Chat")
                    }
                    .offset(y: -60)
                } 
                
                
                
            }
        }
        .padding()
        .alert(isPresented: $alertShowing) {
            Alert(title: Text("Oops, something went wrong!"), message: Text(self.errMessage), dismissButton: .default(Text("Ok")))
        }
        .frame(width: UIScreen.main.bounds.width + 100, height: UIScreen.main.bounds.height)
        .offset(y: 25)

    }
}
