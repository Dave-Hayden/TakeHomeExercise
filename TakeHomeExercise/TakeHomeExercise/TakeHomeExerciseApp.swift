//
//  TakeHomeExerciseApp.swift
//  TakeHomeExercise
//
//  Created by dh on 10/5/24.
//

import SwiftUI

@main
struct TakeHomeExerciseApp: App {
    var body: some Scene {
        WindowGroup {
            let viewModel = RecipeViewModel()    // Initialize the ViewModel here
            RecipeListView(viewModel: viewModel) // Pass the ViewModel to the View
        }
    }
}
