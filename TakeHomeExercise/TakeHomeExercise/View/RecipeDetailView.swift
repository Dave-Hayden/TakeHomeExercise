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
            } else {
                // Show error if neither video
                Text("No video available")
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
