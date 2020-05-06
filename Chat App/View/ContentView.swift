//
//  ContentView.swift
//  Chat App
//
//  Created by Jefferson Ly on 4/26/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        Group {
            if(session.session != nil) {
//                Text("Welcome back \(session.session!.name ?? "user")")
//                Button(action: session.signOut) {
//                    Text("Sign Out")
//                }
                HomeView()
            } else {
                AuthView()
            }
        }.onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
