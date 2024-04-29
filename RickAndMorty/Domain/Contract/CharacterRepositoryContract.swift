//
//  CharacterRepositoryContract.swift
//  RickAndMorty
//
//  Created by Leticia Echarri on 28/4/24.
//

import Foundation

protocol CharacterRepositoryContract {
    func getAllCharacters() async throws -> [CharacterModel]
    func getCharacters(by pageNumber: Int) async throws -> [CharacterModel]
}
