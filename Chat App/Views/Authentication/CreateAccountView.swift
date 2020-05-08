//
//  CreateAccountView.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/6/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI

struct CreateAccount: View {
    
    @Binding var show: Bool
    @State var name = "" //name of user
    @State var info = "" //information and details of user
    @State var picker = false
    @State var loading = false
    @State var imageData : Data = .init(count: 0) //image data
    @State var alert = false
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text("Fill in the fields to create your account!").font(.largeTitle).fontWeight(.heavy).foregroundColor(.blue)
            HStack {
                Spacer()
                Button(action: {
                    self.picker.toggle()
                }) {
                    
                    //if image isn't selected display default, otherwise display image
                    if self.imageData.count == 0 {
                        Image(systemName: "person.crop.circle.badge.plus").resizable().frame(width: 90, height: 70).foregroundColor(.blue)
                    } else {
                        Image(uiImage: UIImage(data: self.imageData)!).resizable().renderingMode(.original).frame(width: 90, height: 70).foregroundColor(.blue).clipShape(Circle())
                    }
                }
                Spacer()
            }
            .padding(.vertical, 12)
            
            Text("Enter Name")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 2)
            
            TextField("Name", text: self.$name)
                .keyboardType(.numberPad)
                .padding()
                .background(Color("Color"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 16)
            
            Text("About You")
                .font(.body)
                .foregroundColor(.gray)
                .padding(.top, 2)
            
            TextField("About", text: self.$info)
                .keyboardType(.numberPad)
                .padding()
                .background(Color("Color"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.top, 16)
            
            if self.loading {
                HStack {
                    Spacer()
                    Indicator()
                    Spacer()
                }
            } else {
                Button(action: {
                    
                    if self.name != "" && self.info != "" && self.imageData.count != 0 {
                        self.loading.toggle()
                        CreateUser(name: self.name, info: self.info, imageData: self.imageData) { (status) in
                            if status {
                                self.show.toggle()
                            }
                        }
                    } else {
                        self.alert.toggle()
                    }
                    
                }) {
                    Text("Create").frame(width: UIScreen.main.bounds.width - 30, height: 50)
                }
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Text("If stuck on loading for more than 5 seconds, just swipe down! Everything should be finished loading!")
            .font(.body)
            .foregroundColor(.gray)
            .padding(.top, 2)
        }
        .padding()
        .sheet(isPresented: self.$picker, content: {
            ImagePicker(picker: self.$picker, imageData: self.$imageData)
        })
        .alert(isPresented: self.$alert) {
            Alert(title: Text("Message"), message: Text("Please fill out all the fields"), dismissButton: .default(Text("Ok")))
        }
    }
}
