//
//  GetCharactersByNameUseCaseTests.swift
//  RickAndMortyTests
//
//  Created by Leticia Echarri on 5/5/24.
//

import XCTest
@testable import RickAndMorty

final class GetCharactersByNameUseCaseTests: XCTestCase {
    var repository: CharacterRepositoryMock!
    var sut: GetCharactersByNameUseCase!
    
    override func setUp() {
        repository = CharacterRepositoryMock()
        sut = GetCharactersByNameUseCase(repository: repository)
    }
    
    func testGetCharacters() async {
        do {
            let name = "Rick"
            let characters = try await sut.execute(name: name)
            XCTAssertNotNil(characters)
            XCTAssertFalse(characters.isEmpty)
            XCTAssertTrue(characters.first!.name.contains(name))
        } catch {
            XCTFail("Invalid expected result")
        }
    }
    
    func testGetCharactersFailure() async {
        repository.error = NSError(domain: "",
                                   code: 0,
                                   userInfo: ["error": "Error"])
        
        do {
            _ = try await sut.execute(name: "rick")
            XCTFail("Invalid expected result")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
