//
//  Character.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 28/4/24.
//

import Foundation

struct CharacterEntity {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: CharacterOriginEntity
    let location: CharacterLocationEntity
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct CharacterOriginEntity: Codable {
    let name: String
    let url: String
}

struct CharacterLocationEntity: Codable {
    let name: String
    let url: String
}
