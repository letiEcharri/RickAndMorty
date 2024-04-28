//
//  UIImageView+UrlImage.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 29/4/24.
//

import UIKit

extension UIImageView {
    func downloadImage(from url: URL) async throws {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let imageDownloaded = UIImage(data: data) else {
            throw ImageError.invalidData
        }
        self.image = imageDownloaded
    }

    enum ImageError: Error {
        case invalidData
    }
}
