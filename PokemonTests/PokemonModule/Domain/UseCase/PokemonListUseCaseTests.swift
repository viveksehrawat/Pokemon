//
//  PokemonListUseCaseTests.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 26/10/23.
//


import XCTest
@testable import Pokemon

class PokemonListUseCaseTests: XCTestCase {

    var mockPokemonRepository: MockPokemonRepository!
    var mockPokemonDetailRepository: MockPokemonDetailRepository!
    var pokemonListUseCase: PokemonListUseCaseImpl!

    override func setUp() {
        super.setUp()
        mockPokemonRepository = MockPokemonRepository()
        mockPokemonDetailRepository = MockPokemonDetailRepository()
        pokemonListUseCase = PokemonListUseCaseImpl(respository: mockPokemonRepository, pokemonDetailRepository: mockPokemonDetailRepository)
    }

    override func tearDown() {
        super.tearDown()
    }

    // Test for fetching the list of Pokemon
    func testFetchPokemonList() async {
        let expectedPokemonPage = PokemonListMockData.pokemonPage
          mockPokemonRepository.page = expectedPokemonPage
          do {
              let result = try await pokemonListUseCase.fetchPokemonList()
              XCTAssertNotNil(result)
          } catch {
              XCTFail("Error occurred: \(error)")
          }
    }

    // Test for fetching Pokemon detail
    func testFetchPokemonDetail() async {
        let expectedPokemonDetail = PokemonDetailMockData.domainPokemonDetail
        mockPokemonDetailRepository.detail = expectedPokemonDetail

        do {
            let result = try await pokemonListUseCase.fetchPokemonDetail(for: "testName")
            XCTAssertNotNil(result)
        } catch {
            XCTFail("Error occurred: \(error)")
        }
    }
}
