//
//  MovieService.swift
//  DumbCharades
//
//  Created by Pavan on 7/23/21.
//

import Foundation
import Combine

final class MovieService {
    let httpClient = HttpClient()
    
    static let baseURL = URL(string: "https://www.dumbcharades.app/api/")!
    private let decoder = JSONDecoder()
    /// Specify the scheduler that manages the responses
    private let apiQueue = DispatchQueue(label: "MovieServiceAPI",
                                         qos: .default,
                                         attributes: .concurrent)

    func getRandomMovie(year: Int, language: Language) -> AnyPublisher<Movie, Error
    > {
        var queryURL = URLComponents(url: MovieService.baseURL.appendingPathComponent("movie"), resolvingAgainstBaseURL: false)!
        
        queryURL.queryItems =
            [URLQueryItem(name: "year", value: String(year)),
             URLQueryItem(name: "language", value: language.description)]

        return httpClient.run(URLRequest(url: queryURL.url!))
                .map(\.value)
                .eraseToAnyPublisher()
    }
}
