//
//  OnRouteMoodApp.swift
//  OnRouteMood
//
//  Created by Alessandro Bizzoni on 14/5/25.
//

import SwiftUI

@main
struct OnRouteMoodApp: App {
    var body: some Scene {
        WindowGroup {
            ORMMainView(
                viewModel: ORMMainViewModel(
                    ormInteractor: ORMInteractor(
                        networkManager: Network()
                    )
                )
            )
        }
    }
}
