//
//  CharachterImageView.swift
//  UserDefaults_URLCashe
//
//  Created by Айдар Нуркин on 05.03.2023.
//

import UIKit

class CharachterImageView: UIImageView {

    func fetchImage(from url: String) {
        guard let imageURL = URL(string: url) else {
            image = UIImage(named: "picture")
            return
        }
        // From cash
        if let cachedImage = getCacheImage(from: imageURL) {
            image = cachedImage
            return
        }
        // Загрузка изображения из сети
        ImageManager.shared.fetchData(from: imageURL) { (data, response) in
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            // Save to cash
            self.saveDataToCashe(with: data, response: response)
        }
    }
    private func saveDataToCashe(with data: Data, response: URLResponse) {
        guard let url = response.url else { return }
        let urlRequest = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: urlRequest)
    }
    private func getCacheImage(from url: URL) -> UIImage? {
        let urlRequest = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: urlRequest) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }

}

