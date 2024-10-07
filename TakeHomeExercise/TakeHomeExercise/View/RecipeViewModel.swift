//
//  RecipeViewModel.swift
//  TakeHomeExercise
//
//  Created by dh on 10/5/24.
//

import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let recipeService: RecipeServiceProtocol

    init(recipeService: RecipeServiceProtocol = RecipeService()) {
        self.recipeService = recipeService
        Task {
            await fetchRecipes()
        }
    }

    func fetchRecipes() async {
        isLoading = true
        do {
            let fetchedRecipes = try await recipeService.fetchRecipes()
            self.recipes = fetchedRecipes
            self.errorMessage = nil
        } catch {
            self.errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}
