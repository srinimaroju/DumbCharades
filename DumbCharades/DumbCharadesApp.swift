//
//  DumbCharadesApp.swift
//  DumbCharades
//
//  Created by Pavan on 7/23/21.
//

import SwiftUI

@main
struct DumbCharadesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
