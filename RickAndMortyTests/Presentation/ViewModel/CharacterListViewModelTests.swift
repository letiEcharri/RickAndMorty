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
    var getCharactersByNameUseCase: GetCharactersByNameUseCaseMock!
    var sut: CharacterListViewModel!
    
    override func setUp() {
        coordinator = CoordinatorMock()
        getCharactersByPageNameUseCase = GetCharactersByPageNameUseCaseMock()
        getCharactersByNameUseCase = GetCharactersByNameUseCaseMock()
        let useCases = CharacterListViewModel.UseCases(getCharactersByPage: getCharactersByPageNameUseCase,
                                                       getCharactersByName: getCharactersByNameUseCase)
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
    
    func testDidItemSelect() async {
        await sut.viewDidLoad()
        sut.didSelect(1)
        
        XCTAssertTrue(coordinator.isNavigateToDetailCalled)
    }
    
    func testDidItemSelectFailure() async {
        await sut.viewDidLoad()
        sut.didSelect(10)
        
        XCTAssertFalse(coordinator.isNavigateToDetailCalled)
    }
    
    func testSearch() async {
        let name = "rick"
        await sut.search(name: name, isSearchActive: true)
        
        let characters = CharacterRepositoryMock().characters.compactMap { item in
            CharacterListCell.Model(imageUrlString: item.image,
                                    name: item.name,
                                    id: item.id)
        }
        let result = characters.filter({ $0.name.contains(name) })
        
        XCTAssertEqual(sut.viewState, .updateList(result))
    }
    
    func testSearchDeactivate() async {
        let name = "rick"
        await sut.search(name: name, isSearchActive: false)
        
        let characters = CharacterRepositoryMock().characters.compactMap { item in
            CharacterListCell.Model(imageUrlString: item.image,
                                    name: item.name,
                                    id: item.id)
        }
        
        XCTAssertEqual(sut.viewState, .updateList(characters))
    }
    
    
    func testSearchEmpty() async {
        await sut.search(name: "", isSearchActive: true)
        
        let characters = CharacterRepositoryMock().characters.compactMap { item in
            CharacterListCell.Model(imageUrlString: item.image,
                                    name: item.name,
                                    id: item.id)
        }
        
        XCTAssertEqual(sut.viewState, .updateList(characters))
    }
}
