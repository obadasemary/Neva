//
//  NevaApp.swift
//  Neva
//
//  Created by Abdelrahman Mohamed on 28.10.2025.
//

import SwiftUI

@main
struct NevaApp: App {
    var body: some Scene {
        WindowGroup {
            let feedBuilder = FeedBuilder()
            feedBuilder.buildFeedView()
        }
    }
}
