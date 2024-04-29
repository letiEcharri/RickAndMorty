//
//  GetCharactersByPageNameUseCaseMock.swift
//  RickAndMortyTests
//
//  Created by Leticia Echarri on 29/4/24.
//

import Foundation
@testable import RickAndMorty

class GetCharactersByPageNameUseCaseMock: GetCharactersByPageNameUseCaseContract {
    var error: Error?
    
    func execute(by pageName: Int) async throws -> [CharacterModel] {
        if let error = error {
            throw error
        }
        return try await CharacterRepositoryMock().getAllCharacters()
    }
}
