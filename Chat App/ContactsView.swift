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
        ZStack(alignment: .topLeading) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {

                    Text("Contacts")
                        .foregroundColor(Color.white)
                        .offset(y: 25)
                        .offset(x: -20)
                        .font(.system(size: 50))
                    Button("+ Add Friends", action: addFriendsViewTransition)
                        .font(.system(size: 25))
                        .foregroundColor(Color.black)
                        .border(Color.white, width: 2)
                        .background(Color.white)
                        .cornerRadius(40)
                        .offset(x: 15)
                        .offset(y: 25)
                    
                }
                TextField("Search", text: $searchContent)
                    .offset(x: 25)
                    .background(Color.white)
                    .frame(width: 350, height: 25)
                    .cornerRadius(40)
                    .padding()
                
                List {
                    ContactItemView()
                    ContactItemView()
                    ContactItemView()
                    ContactItemView()
                    ContactItemView()
                    ContactItemView()
                    ContactItemView()
                    ContactItemView()
                    
                }
                
                
                
                
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
