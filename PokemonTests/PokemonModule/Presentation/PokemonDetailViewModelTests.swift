//
//  PokemonDetailViewModelTests.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 26/10/23.
//


import XCTest
@testable import Pokemon

class PokemonDetailViewModelTests: XCTestCase {

    var viewModel: PokemonDetailViewModel!
    var mockUseCase: MockDetailUseCase!
    var mockPokemonDetail: PokemonDetail!

    override func setUp() {
        super.setUp()

        // Initialize the mock use case and the view model
        mockUseCase = MockDetailUseCase()

        let allPokemons: [PokemonDetail] = [PokemonDetailMockData.domainPokemonDetail]
        viewModel = PokemonDetailViewModel(useCase: mockUseCase, selectedIndex: 0, allPokemons: allPokemons)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoad_Success() async throws {
        // Set up the mock data for a successful load
        mockUseCase.detail = PokemonDetailMockData.domainPokemonDetail
        mockUseCase.pokemonDescription = PokemonDescMockData.domainPokemonDesc
        mockUseCase.pokemonWeakness = PokemonWeaknessMockData.domainPokemonWeakness
        mockUseCase.evolutionChain = PokemonEvolutionMockData.domainPokemonEvolution

        await viewModel.load()
        
        // Create an expectation for waiting
        let expectation = XCTestExpectation(description: "Loading completed")
        
        // Wait for a maximum of 5 seconds
        let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        print("*************", viewModel.pageData.pokemonDetail?.name)
       
        XCTAssertTrue(viewModel.pageData.pokemonDetail?.name == "venusaur")

      
    }


}
