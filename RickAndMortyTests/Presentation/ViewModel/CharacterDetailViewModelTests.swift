//
//  CharacterDetailViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Leticia Echarri on 29/4/24.
//

import XCTest
@testable import RickAndMorty

final class CharacterDetailViewModelTests: XCTestCase {
    var coordinator: CoordinatorMock!
    var sut: CharacterDetailViewModel!
    
    var character: CharacterModel {
        CharacterRepositoryMock().characters.first!
    }
    
    override func setUp() {
        coordinator = CoordinatorMock()
        sut = CharacterDetailViewModel(coordinator: coordinator,
                                       character: character)
    }
    
    func testViewDidLoad() async {
        sut.viewDidLoad()
        let model = CharacterDetailViewController.Model(imageUrlString: character.image,
                                                        name: character.name,
                                                        species: character.species,
                                                        status: .init(rawValue: character.status.rawValue) ?? .unknown,
                                                        location: character.location.name,
                                                        episodes: character.episode,
                                                        gender: character.gender)
        XCTAssertEqual(sut.viewState, .update(model))
    }
}
