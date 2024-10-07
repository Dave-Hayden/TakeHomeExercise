//
//  RecipeRow.swift
//  TakeHomeExercise
//
//  Created by dh on 10/5/24.
//

import SwiftUI
import Foundation

struct RecipeRow: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            AsyncImage(url: recipe.photoUrlSmall) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                case .failure:
                    Image("placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                case .empty:
                    ProgressView()
                @unknown default:
                    Image("placeholder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading) {
                Text(recipe.name).font(.headline)
                Text(recipe.cuisine).font(.subheadline).foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
