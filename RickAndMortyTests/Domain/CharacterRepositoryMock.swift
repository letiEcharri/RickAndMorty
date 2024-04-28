//
//  CharacterRepositoryMock.swift
//  RickAndMortyTests
//
//  Created by Leticia Echarri on 28/4/24.
//

import Foundation
@testable import RickAndMorty

class CharacterRepositoryMock: CharacterRepositoryContract {
    var error: Error?
    
    func getAllCharacters() async throws -> [CharacterModel] {
        if let error = error {
            throw error
        }
        return [
            CharacterModel(id: 1,
                           name: "Rick",
                           status: "Alive",
                           species: "Human",
                           type: "",
                           gender: "Male",
                           origin: CharacterOriginModel(name: "", url: ""),
                           location: CharacterLocationModel(name: "", url: ""),
                           image: "",
                           episode: [],
                           url: "",
                           created: ""),
            CharacterModel(id: 2,
                           name: "Morty",
                           status: "Alive",
                           species: "Human",
                           type: "",
                           gender: "Male",
                           origin: CharacterOriginModel(name: "", url: ""),
                           location: CharacterLocationModel(name: "", url: ""),
                           image: "",
                           episode: [],
                           url: "",
                           created: "")
        ]
    }
}
