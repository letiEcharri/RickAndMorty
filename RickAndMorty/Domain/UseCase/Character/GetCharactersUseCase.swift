//
//  GetCharactersUseCase.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 28/4/24.
//

import Foundation

protocol GetCharactersUseCaseContract {
    func execute() async throws -> [CharacterModel]
}

struct GetCharactersUseCase: GetCharactersUseCaseContract {
    private let repository: CharacterRepositoryContract

    init(repository: CharacterRepositoryContract) {
        self.repository = repository
    }
    
    func execute() async throws -> [CharacterModel] {
        try await repository.getAllCharacters()
    }
}
