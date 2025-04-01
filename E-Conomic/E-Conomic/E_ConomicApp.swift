//
//  E_ConomicApp.swift
//  E-Conomic
//
//  Created by Kazim Ahmad on 31/03/2025.
//

import SwiftUI

@main
struct E_ConomicApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
