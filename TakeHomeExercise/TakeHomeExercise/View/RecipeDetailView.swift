//
//  RecipeDetailView.swift
//  TakeHomeExercise
//
//  Created by dh on 10/7/24.
//

import SwiftUI
import WebKit

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        VStack {
            if let youtubeUrl = recipe.youtubeUrl {
                WebView(url: youtubeUrl)
                    .frame(height: 300)
            } else if let imageUrl = recipe.photoUrlLarge {
                AsyncImage(url: imageUrl) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 300)
                    } else if phase.error != nil {
                        Text("Failed to load image")
                            .foregroundColor(.red)
                    } else {
                        ProgressView("Loading Image...")
                    }
                }
            } else {
                // Show error if neither video nor image exists
                Text("No video or image available")
                    .foregroundColor(.red)
                    .font(.headline)
            }
            Spacer()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// WebView to embed the YouTube video
struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
