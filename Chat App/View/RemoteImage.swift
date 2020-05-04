//
//  RemoteImage.swift
//  Chat App
//
//  Created by Jefferson Ly on 5/3/20.
//  Copyright © 2020 Jefferson & Sean. All rights reserved.
//

import SwiftUI

struct RemoteImage: View {
    @ObservedObject var imageLoader = ImageLoader()
    var placeholder: Image
    
    init(url: String, placeholder: Image = Image(systemName: "photo")) {
        self.placeholder = placeholder
        imageLoader.fetchImage(url: url)
    }
    
    var body: some View {
        if let image = self.imageLoader.downloadImage {
            return Image(uiImage: image)
        }
        return placeholder
    }
}

struct RemoteImage_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImage(url: "")
    }
}
