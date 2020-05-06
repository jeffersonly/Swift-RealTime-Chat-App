//
//  ContactsView.swift
//  Message App Final
//
//  Created by Sean Quach on 5/3/20.
//  Copyright © 2020 Jefferson and Sean. All rights reserved.
//

import SwiftUI

struct ContactsView: View {
    
    @State private var searchContent: String = ""
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Color.black.edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        
                        Text("Contacts")
                            .foregroundColor(Color.white)
                            .offset(y: 25)
                            .offset(x: -20)
                            .font(.system(size: 50))
                        NavigationLink(destination: AddFriendsView()) {
                            Text("+Add Friends")
                                .font(.system(size: 25))
                                .foregroundColor(Color.black)
                                .border(Color.white, width: 2)
                                .background(Color.white)
                                .cornerRadius(40)
                                .offset(x: 15)
                                .offset(y: 25)
                        }
                        .navigationBarTitle("Back")
                        
                    }
                    TextField("Search", text: $searchContent)
                        .offset(x: 25)
                        .background(Color.white)
                        .frame(width: 350, height: 25)
                        .cornerRadius(40)
                        .padding()
                    
                    List {
                        NavigationLink(destination: ContactView(name:"Travis Le")) {
                            ContactItemView(name: "Travis Le")
                        }
                        .listRowBackground(Color.black)
                        .background(Color.black)
                        NavigationLink(destination: ContactView(name:"Tom Smith")) {
                            ContactItemView(name: "Tom Smith")
                        }
                        .listRowBackground(Color.black)
                        .background(Color.black)
                        NavigationLink(destination: ContactView(name:"Anna Tran")) {
                            ContactItemView(name: "Anna Tran")
                        }
                        .listRowBackground(Color.black)
                        .background(Color.black)
                        NavigationLink(destination: ContactView(name:"Brian Le")) {
                            ContactItemView(name: "Brian Le")
                        }
                        .listRowBackground(Color.black)
                        .background(Color.black)
                        NavigationLink(destination: ContactView(name:"Phil Tran")) {
                            ContactItemView(name: "Phil Tran")
                        }
                        .listRowBackground(Color.black)
                        .background(Color.black)
                        NavigationLink(destination: ContactView(name:"Jenny Luu")) {
                            ContactItemView(name: "Jenny Luu")
                        }
                        .listRowBackground(Color.black)
                        .background(Color.black)
                        NavigationLink(destination: ContactView(name:"Calvin Ly")) {
                            ContactItemView(name: "Calvin Ly")
                        }
                        .listRowBackground(Color.black)
                        .background(Color.black)
                        
                    }
                    .frame(width: 450, height: 600)
                    
                    
                    
                    
                    
                    
                }   .offset(y: -20)
                
                
            }
        }
    }
    // TODO go to add friends view
    func addFriendsViewTransition() {
        
    }
    
}

struct ContactsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsView()
    }
}
