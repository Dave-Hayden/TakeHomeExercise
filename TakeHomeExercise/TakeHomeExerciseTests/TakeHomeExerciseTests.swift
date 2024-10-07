//
//  TakeHomeExerciseTests.swift
//  TakeHomeExerciseTests
//
//  Created by dh on 10/5/24.
//

import XCTest
@testable import TakeHomeExercise

class MockRecipeService: RecipeServiceProtocol {
    
    var shouldReturnError = false

    func fetchRecipes() async throws -> [Recipe] {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch recipes"])
        } else {
            return loadMockRecipeJSON()
        }
    }

    func loadMockRecipeJSON() -> [Recipe] {
        let jsonData = """
        [
            {
                "cuisine": "Malaysian",
                "name": "Apam Balik",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
            },
            {
                "cuisine": "British",
                "name": "Apple & Blackberry Crumble",
                "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
            }
        ]
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        let recipes = try! decoder.decode([Recipe].self, from: jsonData)
        return recipes
    }
}

class RecipeViewModelTests: XCTestCase {

    var viewModel: RecipeViewModel!
    var mockService: MockRecipeService!

    @MainActor
    override func setUp() {
        super.setUp()
        mockService = MockRecipeService()
        viewModel = RecipeViewModel(recipeService: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    @MainActor
    func testFetchRecipesSuccess() async {
        // Given
        mockService.shouldReturnError = false

        // When
        await viewModel.fetchRecipes()

        // Then
        XCTAssertEqual(viewModel.recipes.count, 2, "Expected 2 recipes in the view model")
        XCTAssertEqual(viewModel.recipes.first?.name, "Apam Balik", "Expected first recipe to be 'Apam Balik'")
        XCTAssertNil(viewModel.errorMessage, "Error message should be nil when fetch is successful")
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching")
    }

    @MainActor
    func testFetchRecipesFailure() async {
        // Given
        mockService.shouldReturnError = true

        // When
        await viewModel.fetchRecipes()

        // Then
        XCTAssertTrue(viewModel.recipes.isEmpty, "Recipes should be empty when fetch fails")
        XCTAssertEqual(viewModel.errorMessage, "Failed to fetch recipes", "Error message should be set when fetch fails")
        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetching")
    }
}

class RecipeServiceTests: XCTestCase {

    var mockService: MockRecipeService!

    override func setUp() {
        super.setUp()
        mockService = MockRecipeService()
    }

    override func tearDown() {
        mockService = nil
        super.tearDown()
    }

    @MainActor
    func testFetchRecipesSuccess() async {
        // Given
        mockService.shouldReturnError = false

        // When
        let recipes = try! await mockService.fetchRecipes()

        // Then
        XCTAssertEqual(recipes.count, 2, "Expected 2 recipes in the result")
    }

    @MainActor
    func testFetchRecipesFailure() async {
        // Given
        mockService.shouldReturnError = true

        // When
        do {
            _ = try await mockService.fetchRecipes()
            XCTFail("Expected failure but got success")
        } catch {
            XCTAssertEqual(error.localizedDescription, "Failed to fetch recipes")
        }
    }
}
