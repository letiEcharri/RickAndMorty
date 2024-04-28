//
//  CharacterRepositoryTests.swift
//  RickAndMortyTests
//
//  Created by Leticia Echarri on 28/4/24.
//

import XCTest
@testable import RickAndMorty

final class CharacterRepositoryTests: XCTestCase {
    var dataSource: RMDataSourceMock!
    var sut: CharacterRepository!
    
    override func setUp() {
        dataSource = RMDataSourceMock()
        sut = CharacterRepository(.rickAndMorty(dataSource))
    }
    
    func testGetAllCharacters() async {
        do {
            let characters = try await sut.getAllCharacters()
            XCTAssertNotNil(characters)
            XCTAssertFalse(characters.isEmpty)
        } catch {
            XCTFail("Invalid expected result")
        }
    }
    
    func testGetAllCharactersFailure() async {
        dataSource.error = NSError(domain: "",
                                   code: 0,
                                   userInfo: ["error": "Error"])
        
        do {
            _ = try await sut.getAllCharacters()
            XCTFail("Invalid expected result")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
