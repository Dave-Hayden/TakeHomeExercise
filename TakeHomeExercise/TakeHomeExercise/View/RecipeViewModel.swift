//
//  RecipeViewModel.swift
//  TakeHomeExercise
//
//  Created by dh on 10/5/24.
//

import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let recipeService: RecipeServiceProtocol

    init(recipeService: RecipeServiceProtocol = RecipeService()) {
        self.recipeService = recipeService
        fetchRecipes()
    }

    func fetchRecipes() {
        isLoading = true
        recipeService.fetchRecipes { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let recipes):
                    self?.recipes = recipes
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
