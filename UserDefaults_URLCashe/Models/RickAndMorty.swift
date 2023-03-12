//
//  RickAndMorty.swift
//  UserDefaults_URLCashe
//
//  Created by Айдар Нуркин on 05.03.2023.
//

import Foundation

struct RickAndMorty: Decodable {
    let results: [Result]
}
struct Result: Decodable {
    let name: String
    let image: String
    let url: String
}

enum URLS: String {
    case rickandmortyapi = "https://rickandmortyapi.com/api/character"
}
