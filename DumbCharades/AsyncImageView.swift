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
        _url = url
        _loader = StateObject(wrappedValue: ImageLoader())
        self.placeholder = placeholder()
    }

    var body: some View {
        ImageView().onChange(of: self.url) { (url) in
            load(url: url)
        }
        .onAppear(perform: {
            load(url: url)
        })
    }
    
    @ViewBuilder func ImageView() -> some View {
        if loader.image != nil {
            Image(uiImage: loader.image!).resizable()
        } else {
            placeholder
        }
    }
    
    func load(url: String?) {
        self.loader.load(url: URL(string: url ?? DefaultMovie.imageUrl)!)
    }
}

