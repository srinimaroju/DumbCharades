//
//  AsyncImageView.swift
//  DumbCharades
//
//  Created by Pavan on 7/24/21.
//

import SwiftUI
import Foundation

struct AsyncImageView<Placeholder: View>: View {
    @StateObject private var loader = ImageLoader()
    @Binding var url: String?
    private let placeholder: Placeholder

    init(url: Binding<String?>, @ViewBuilder placeholder: () -> Placeholder) {
        print("calling url \(url)--")
        _url = url
        self.placeholder = placeholder()
        _loader = StateObject(wrappedValue: ImageLoader())
    }

    var body: some View {
        if loader.image != nil {
            let _ = print("actual image \(loader.image!)")
            Image(uiImage: loader.image!)
                .resizable().onChange(of: self.url) { (url) in
                    self.loader.load(url: URL(string: url ?? DefaultMovie.imageUrl)!)
                }
                .onAppear(perform: {
                    self.loader.load(url: URL(string: url ?? DefaultMovie.imageUrl)!)
                })
               
        } else {
            let _ = print("placeholder")
            placeholder.onChange(of: self.url) { (url) in
                self.loader.load(url: URL(string: url ?? DefaultMovie.imageUrl)!)
            }
            .onAppear(perform: {
                self.loader.load(url: URL(string: url ?? DefaultMovie.imageUrl)!)
            })
        }
    }
}

