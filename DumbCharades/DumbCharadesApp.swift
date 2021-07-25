//
//  DumbCharadesApp.swift
//  DumbCharades
//
//  Created by Pavan on 7/23/21.
//

import SwiftUI

@main
struct DumbCharadesApp: App {
    init() {
        movieService = MovieService()
    }
    
    var movieService: MovieService
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
