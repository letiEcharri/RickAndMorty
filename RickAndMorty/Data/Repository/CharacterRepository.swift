//
//  CharacterRepository.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 28/4/24.
//

import Foundation

class CharacterRepository: BaseRepository, CharacterRepositoryContract {
    
    func getAllCharacters() async throws -> [CharacterModel] {
        do {
            guard let request = try await request(client) as? RMDataSource else {
                throw NSError(domain: "", code: 0, userInfo: ["error": "Error with dataSource"])
            }
            
            let characters = try await request.getCharacters()
            
            let domainModel = characters.compactMap { character in
                self.getCharacter(from: character)
            }
            
            return domainModel
        } catch {
            throw error
        }
    }
}

private extension CharacterRepository {
    func getCharacter(from entity: CharacterEntity) -> CharacterModel {
        CharacterModel(id: entity.id,
                       name: entity.name,
                       status: entity.status,
                       species: entity.species,
                       type: entity.type,
                       gender: entity.gender,
                       origin: CharacterOriginModel(name: entity.origin.name,
                                                    url: entity.origin.url),
                       location: CharacterLocationModel(name: entity.location.name,
                                                        url: entity.location.url),
                       image: entity.image,
                       episode: entity.episode,
                       url: entity.url,
                       created: entity.created)
    }
}
