//
//  CoordinatorMock.swift
//  RickAndMortyTests
//
//  Created by Leticia Echarri on 29/4/24.
//

@testable import RickAndMorty

class CoordinatorMock: CoordinatorContract {
    var isStartCalled = false
    
    func start() {
        isStartCalled = true
    }
}
