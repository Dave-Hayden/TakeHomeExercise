//
//  Recipe.swift
//  TakeHomeExercise
//
//  Created by dh on 10/5/24.
//

import Foundation

struct Recipe: Identifiable, Codable {
    var id: String {
        return uuid
    }
    var cuisine: String
    var name: String
    var photoUrlLarge: URL?
    var photoUrlSmall: URL?
    var sourceUrl: URL?
    var uuid: String
    var youtubeUrl: URL?
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case uuid
        case youtubeUrl = "youtube_url"
    }
    
    // Fallback to default values if needed
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        cuisine = (try? container.decode(String.self, forKey: .cuisine)) ?? "Unknown"
        name = (try? container.decode(String.self, forKey: .name)) ?? "Unknown"
        photoUrlLarge = URL(string: (try? container.decode(String.self, forKey: .photoUrlLarge)) ?? "")
        photoUrlSmall = URL(string: (try? container.decode(String.self, forKey: .photoUrlSmall)) ?? "")
        sourceUrl = URL(string: (try? container.decode(String.self, forKey: .sourceUrl)) ?? "")
        uuid = (try? container.decode(String.self, forKey: .uuid)) ?? UUID().uuidString
        youtubeUrl = URL(string: (try? container.decode(String.self, forKey: .youtubeUrl)) ?? "")
    }
}

struct RecipeResponse: Codable {
    var recipes: [Recipe]
}
