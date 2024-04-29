//
//  RMDataSource.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 28/4/24.
//

import Foundation
import RickMortySwiftApi

protocol RMDataSourceContract {
    func getCharacters() async throws -> [CharacterEntity]
    func getCharacters(by pageNumber: Int) async throws -> [CharacterEntity] 
}

class RMDataSource: RMDataSourceContract {
    private var client = RMClient()
    
    private var character: RMCharacter {
        client.character()
    }
    
    private var episode: RMEpisode {
        client.episode()
    }
    
    private var location: RMLocation {
        client.location()
    }
    
    // Functions
    func getCharacters() async throws -> [CharacterEntity] {
        try await character.getAllCharacters().compactMap { character in
            self.getCharacterEntity(from: character)
        }
    }
    
    func getCharacters(by pageNumber: Int) async throws -> [CharacterEntity] {
        try await character.getCharactersByPageNumber(pageNumber: pageNumber).compactMap { character in
            self.getCharacterEntity(from: character)
        }
    }
}

private extension RMDataSource {
    func getCharacterEntity(from character: RMCharacterModel) -> CharacterEntity {
        CharacterEntity(id: character.id,
                        name: character.name,
                        status: character.status,
                        species: character.species,
                        type: character.type,
                        gender: character.gender,
                        origin: CharacterOriginEntity(name: character.origin.name,
                                                      url: character.origin.url),
                        location: CharacterLocationEntity(name: character.location.name,
                                                          url: character.location.url),
                        image: character.image,
                        episode: character.episode,
                        url: character.url,
                        created: character.created)
    }
}
