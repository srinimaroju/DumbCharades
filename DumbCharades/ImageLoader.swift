//
//  ImageService.swift
//  DumbCharades
//
//  Created by Pavan on 7/24/21.
//

import SwiftUI
import Foundation
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private(set) var isLoading = false

    private var url: URL?
    private var cancellable: AnyCancellable?
    
    deinit {
        cancel()
    }

    func load(url: URL) {
        guard !isLoading else { return }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
                          receiveCompletion: { [weak self] _ in self?.onFinish() },
                          receiveCancel: { [weak self] in self?.onFinish() })
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                self?.image = $0
            }
    }
        
    func cancel() {
        let _ = print("cancel")
        cancellable?.cancel()
    }
    
    private func onStart() {
        let _ = print("start")

        isLoading = true
    }
    
    private func onFinish() {
        let _ = print("finish")

        isLoading = false
    }
}

enum HTTPError: LocalizedError {
    case statusCode
    case post
}
