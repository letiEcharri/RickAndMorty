//
//  GetCharactersUseCaseTests.swift
//  RickAndMortyTests
//
//  Created by Leticia Echarri on 28/4/24.
//

import XCTest
@testable import RickAndMorty

final class GetCharactersUseCaseTests: XCTestCase {
    var repository: CharacterRepositoryMock!
    var sut: GetCharactersUseCase!
    
    override func setUp() {
        repository = CharacterRepositoryMock()
        sut = GetCharactersUseCase(repository: repository)
    }
    
    func testGetAllCharacters() async {
        do {
            let characters = try await sut.execute()
            XCTAssertNotNil(characters)
            XCTAssertFalse(characters.isEmpty)
        } catch {
            XCTFail("Invalid expected result")
        }
    }
    
    func testGetAllCharactersFailure() async {
        repository.error = NSError(domain: "",
                                   code: 0,
                                   userInfo: ["error": "Error"])
        
        do {
            _ = try await sut.execute()
            XCTFail("Invalid expected result")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
