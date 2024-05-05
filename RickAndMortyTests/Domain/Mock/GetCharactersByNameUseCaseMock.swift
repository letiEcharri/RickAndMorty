//
//  GetCharactersByNameUseCaseMock.swift
//  RickAndMortyTests
//
//  Created by Leticia Echarri on 5/5/24.
//

import Foundation
@testable import RickAndMorty

class GetCharactersByNameUseCaseMock: GetCharactersByNameUseCaseContract {
    var error: Error?
    
    func execute(name: String) async throws -> [CharacterModel] {
        if let error = error {
            throw error
        }
        return try await CharacterRepositoryMock().getAllCharacters().filter({ $0.name.contains(name) })
    }
}
