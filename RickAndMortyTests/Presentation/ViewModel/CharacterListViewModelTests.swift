//
//  CharacterListViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Leticia Echarri on 29/4/24.
//

import XCTest
@testable import RickAndMorty

final class CharacterListViewModelTests: XCTestCase {
    var coordinator: CoordinatorMock!
    var getCharactersByPageNameUseCase: GetCharactersByPageNameUseCaseMock!
    var sut: CharacterListViewModel!
    
    override func setUp() {
        coordinator = CoordinatorMock()
        getCharactersByPageNameUseCase = GetCharactersByPageNameUseCaseMock()
        let useCases = CharacterListViewModel.UseCases(getCharactersByPage: getCharactersByPageNameUseCase)
        sut = CharacterListViewModel(coordinator: coordinator,
                                     useCases: useCases)
    }
    
    func testViewDidLoad() async {
        await sut.viewDidLoad()
        let characters = CharacterRepositoryMock().characters.compactMap { item in
            CharacterListCell.Model(imageUrlString: item.image,
                                    name: item.name,
                                    id: item.id)
        }
        XCTAssertEqual(sut.viewState, .updateList(characters))
    }
}
