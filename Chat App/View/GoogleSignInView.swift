//
//  GoogleSignInView.swift
//  Chat App
//
//  Created by Jefferson Ly on 4/27/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct GoogleSignView: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<GoogleSignView>) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .light
        button.style = .wide
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton , context: UIViewRepresentableContext<GoogleSignView>) {
        
    }
}
