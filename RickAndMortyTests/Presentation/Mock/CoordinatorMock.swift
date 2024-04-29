//
//  CoordinatorMock.swift
//  RickAndMortyTests
//
//  Created by Leticia Echarri on 29/4/24.
//

@testable import RickAndMorty

class CoordinatorMock: CoordinatorContract {
    var isStartCalled = false
    var isNavigateToDetailCalled = false
    
    func start() {
        isStartCalled = true
    }
    
    func navigateToDetail(with character: RickAndMorty.CharacterModel) {
        isNavigateToDetailCalled = true
    }
}
