//
//  ContactItemView.swift
//  Message App Final
//
//  Created by Sean Quach on 5/3/20.
//  Copyright © 2020 Jefferson and Sean. All rights reserved.
//

import SwiftUI

// view for a contact item
struct ContactItemView: View {
    var name: String
    var body: some View {
        
        HStack {
            Image("profilePic")
                .renderingMode(.original)
                .resizable()
                .clipShape(Circle())
                .frame(width: 50.0, height: 50.0)
            Text(self.name) //TODO placeholder name / replace with actual value or literal string?
                .listRowBackground(Color.black)
                .foregroundColor(Color.white)
                .offset(x: 20)
            
        }
        .padding()
        .listRowBackground(Color.black)
        .background(Color.black)
    }
    
    init(name: String) {
        self.name = name
    }
    
    init() {
        self.name = ""
    }
}

struct ContactItemView_Previews: PreviewProvider {
    static var previews: some View {
        ContactItemView(name: "Kevin Nguyen")
    }
}
