//
//  RickandMortyTests.swift
//  RickandMortyTests
//
//  Created by ali cihan on 21.09.2025.
//

import XCTest
@testable import RickandMorty

final class RickandMortyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCharacterListViewModelCharactersCount() async {
        let vm = CharacterListViewModel(apiService: MockAPIService())
        await vm.fetchCharacters()
        let characterCount = 20
        XCTAssertEqual(vm.charactersSet.count, characterCount)
    }
    
    func testJSONDecoding() async throws {
            // Mock JSON
            let json = """
            {
              "info": {"count": 1, "pages": 1, "next": null, "prev": null},
              "results": [
                {
                  "id": 1,
                  "name": "Rick Sanchez",
                  "status": "Alive",
                  "species": "Human",
                  "type": "",
                  "gender": "Male",
                  "origin": {"name": "Earth", "url": ""},
                  "location": {"name": "Earth", "url": ""},
                  "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                  "episode": [],
                  "url": "",
                  "created": ""
                }
              ]
            }
            """.data(using: .utf8)!
            
            let decoder = JSONDecoder()
            let response = try decoder.decode(CharactersResponse.self, from: json)
            
            XCTAssertEqual(response.results.count, 1)
            XCTAssertEqual(response.results.first?.name, "Rick Sanchez")
            XCTAssertEqual(response.info.count, 1)
        }

}
