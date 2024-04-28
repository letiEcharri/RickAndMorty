//
//  RMDataSourceMock.swift
//  RickAndMortyTests
//
//  Created by Leticia Echarri on 28/4/24.
//

import Foundation
@testable import RickAndMorty

class RMDataSourceMock: RMDataSourceContract {
    var error: Error?
    
    func getCharacters() async throws -> [CharacterEntity] {
        if let error = error {
            throw error
        }
        return [
            CharacterEntity(id: 1,
                            name: "Rick",
                            status: "Alive",
                            species: "Human",
                            type: "",
                            gender: "Male",
                            origin: CharacterOriginEntity(name: "", url: ""),
                            location: CharacterLocationEntity(name: "", url: ""),
                            image: "",
                            episode: [],
                            url: "",
                            created: ""),
            CharacterEntity(id: 2,
                            name: "Morty",
                            status: "Alive",
                            species: "Human",
                            type: "",
                            gender: "Male",
                            origin: CharacterOriginEntity(name: "", url: ""),
                            location: CharacterLocationEntity(name: "", url: ""),
                            image: "",
                            episode: [],
                            url: "",
                            created: "")
        ]
    }
}
