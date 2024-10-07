//
//  RecipeService.swift
//  TakeHomeExercise
//
//  Created by dh on 10/5/24.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes() async throws -> [Recipe]
}

class RecipeService: RecipeServiceProtocol {
    private let apiURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!

    func fetchRecipes() async throws -> [Recipe] {
            let (data, _) = try await URLSession.shared.data(from: apiURL)
            
            // Decode the JSON response
            do {
                let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                return recipeResponse.recipes
            } catch {
                throw error // Rethrow the decoding error
            }
        }
}
