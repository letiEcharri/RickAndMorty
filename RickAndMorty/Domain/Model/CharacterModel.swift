//
//  CharacterModel.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 28/4/24.
//

import Foundation

struct CharacterModel {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOriginModel
    let location: CharacterLocationModel
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct CharacterOriginModel: Codable {
    let name: String
    let url: String
}

struct CharacterLocationModel: Codable {
    let name: String
    let url: String
}
