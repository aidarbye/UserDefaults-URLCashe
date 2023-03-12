//
//  NetworkManager.swift
//  UserDefaults_URLCashe
//
//  Created by Айдар Нуркин on 05.03.2023.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init () {}
    func fetchData(from url: String?, with competition: @escaping (RickAndMorty) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _ , error) in
            if let error = error {
                print(error)
                return
            }
            guard let data = data else {return}
            do {
                let rickAndMorty = try JSONDecoder().decode(RickAndMorty.self, from: data)
                DispatchQueue.main.async {
                    competition(rickAndMorty)
                }
            } catch let error { print(error) }
        }.resume()
    }
}

class ImageManager {
    static let shared = ImageManager()
    private init () {}
    func fetchData(from url: URL, with competition: @escaping (Data,URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response , error) in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            guard url == response.url else { return }
            competition(data,response)
        }.resume()
    }
}
