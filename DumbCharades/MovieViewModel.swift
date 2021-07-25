//
//  MovieViewModel.swift
//  DumbCharades
//
//  Created by Pavan on 7/24/21.
//

import Foundation
import Combine

class MovieViewModel: ObservableObject {
    @Published var movie: Movie = Movie(imageUrl: DefaultMovie.imageUrl, title: "Dumb Charades..!")
    var cancellationToken: AnyCancellable?
}

extension MovieViewModel {
    func getMovies() {
        cancellationToken = MovieService().getRandomMovie(year: 2000, language: Language.english)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in },
                  receiveValue: {  movie in
                    self.movie = movie
            })
    }
}
