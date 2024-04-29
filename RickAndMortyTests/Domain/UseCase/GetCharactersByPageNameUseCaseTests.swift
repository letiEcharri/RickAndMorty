//
//  GetCharactersByPageNameUseCaseTests.swift
//  RickAndMortyTests
//
//  Created by Leticia Echarri on 29/4/24.
//

import XCTest
@testable import RickAndMorty

final class GetCharactersByPageNameUseCaseTests: XCTestCase {
    var repository: CharacterRepositoryMock!
    var sut: GetCharactersByPageNameUseCase!
    
    override func setUp() {
        repository = CharacterRepositoryMock()
        sut = GetCharactersByPageNameUseCase(repository: repository)
    }
    
    func testGetCharacters() async {
        do {
            let characters = try await sut.execute(by: 1)
            XCTAssertNotNil(characters)
            XCTAssertFalse(characters.isEmpty)
        } catch {
            XCTFail("Invalid expected result")
        }
    }
    
    func testGetCharactersFailure() async {
        repository.error = NSError(domain: "",
                                   code: 0,
                                   userInfo: ["error": "Error"])
        
        do {
            _ = try await sut.execute(by: 1)
            XCTFail("Invalid expected result")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
