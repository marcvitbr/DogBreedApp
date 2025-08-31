//
//  CachedAsyncImage.swift
//  DogBreedsApp
//
//  Created by Marcelo Vitoria on 31/08/2025.
//

import SwiftUI

class ImageCache {
    static let shared = NSCache<NSURL, UIImage>()
}

@MainActor
struct CachedAsyncImage: View {
    let url: URL?

    @State private var image: UIImage?

    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                Image(systemName: "photo")
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }

    private func loadImage() {
        guard let url = url else {
            return
        }

        if let cached = ImageCache.shared.object(forKey: url as NSURL) {
            image = cached
            return
        }

        Task {
            if let data = try? await URLSession.shared.data(from: url).0,
               let uiImage = UIImage(data: data)
            {
                ImageCache.shared.setObject(uiImage, forKey: url as NSURL)

                await MainActor.run {
                    image = uiImage
                }
            }
        }
    }
}
