//
//  PokemonDetailUseCaseTests.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 26/10/23.
//


import XCTest
@testable import Pokemon

class PokemonDetailUseCaseTests: XCTestCase {
    
    var mockPokemonDetailRepository: MockPokemonDetailRepository!
    var pokemonDetailUseCase: PokemonDetailUseCaseImpl!
    
    override func setUp() {
        super.setUp()
        mockPokemonDetailRepository = MockPokemonDetailRepository()
        pokemonDetailUseCase = PokemonDetailUseCaseImpl(pokemonDetailRepository: mockPokemonDetailRepository)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    // Test for fetching Pokemon detail
    func testFetchPokemonDetail() async throws {
        let expectedPokemonDetail = PokemonDetailMockData.domainPokemonDetail
        mockPokemonDetailRepository.detail = expectedPokemonDetail
        
        let result =  try await pokemonDetailUseCase.fetchPokemonDetail(for: "testName")
        XCTAssertNotNil(result)
        
    }
    
    
    
    // Test for fetching Pokemon desc
    func testFetchPokemonDescription() async throws {
        let expectedPokemonDesc = PokemonDescMockData.domainPokemonDesc
        mockPokemonDetailRepository.pokemonDescription = expectedPokemonDesc
        
        let result = try await pokemonDetailUseCase.fetchPokemonDescription(for: 2)
        XCTAssertNotNil(result)
    }
    
    // Test for fetching Pokemon weakness
    func testFetchPokemonWeakness() async throws{
        let expectedPokemonWeak = PokemonWeaknessMockData.domainPokemonWeakness
        mockPokemonDetailRepository.pokemonWeakness = expectedPokemonWeak
        
        let result = try await pokemonDetailUseCase.fetchPokemonWeakness(for: 4)
        XCTAssertNotNil(result)
        
    }
    
    // Test for fetching Pokemon evolution
    func testFetchPokemonEvolution() async throws{
        let expectedPokemonEvolution = PokemonEvolutionMockData.domainPokemonEvolution
        mockPokemonDetailRepository.evolutionChain = expectedPokemonEvolution
        
        let result = try await pokemonDetailUseCase.fetchPokemonEvolutionChain(for: "testName")
        XCTAssertNotNil(result)
        
    }
    
    // Test for fetching Pokemon detail and checking the count
    func test_pokemon_detail_name() async throws {
        let expectedPokemonDetailName = "venusaur"
        
        let expectedPokemonDetail = PokemonDetailMockData.domainPokemonDetail
        mockPokemonDetailRepository.detail = expectedPokemonDetail
        
        let result =  try await pokemonDetailUseCase.fetchPokemonDetail(for: "testName")
        XCTAssertEqual(result.name, expectedPokemonDetailName)
    }

}

