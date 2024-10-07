//
//  RecipeService.swift
//  TakeHomeExercise
//
//  Created by dh on 10/5/24.
//

import Foundation

protocol RecipeServiceProtocol {
    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void)
}

class RecipeService: RecipeServiceProtocol {
    private let apiURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")! //  "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!

    func fetchRecipes(completion: @escaping (Result<[Recipe], Error>) -> Void) {
        URLSession.shared.dataTask(with: apiURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            do {
                let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
                completion(.success(recipeResponse.recipes))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
