//
//  DateLabApp.swift
//  DateLab
//
//  Created by Volnei Foss on 02/03/26.
//

import SwiftUI

@main
struct DateLabApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewViewModel())
        }
    }
}
