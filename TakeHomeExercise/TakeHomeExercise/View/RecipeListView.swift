//
//  RecipeListView.swift
//  TakeHomeExercise
//
//  Created by dh on 10/5/24.
//

import SwiftUI
import Foundation

struct RecipeListView: View {
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Recipes...")
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                } else {
                    List(viewModel.recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            RecipeRow(recipe: recipe)
                        }
                    }
                    .refreshable {
                        await viewModel.fetchRecipes()
                    }
                }
            }
            .navigationTitle("Recipes")
        }
    }
}
