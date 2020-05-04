//
//  ImageLoader.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/3/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    var downloadImage: UIImage?
    func fetchImage(url:String) {
        guard let imageURL = URL(string: url) else {
            fatalError("The url string is invalid")
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            guard let data = data, error == nil else {
                fatalError("error reading the image")
            }
            
            DispatchQueue.main.async {
                self.downloadImage = UIImage(data: data)
            }
        }.resume()
    }
}
