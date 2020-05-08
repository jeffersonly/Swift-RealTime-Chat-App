//
//  Indicator.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/6/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI

struct Indicator: UIViewRepresentable {
    func makeUIView (context: UIViewRepresentableContext<Indicator>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Indicator>) {
        
    }
}
