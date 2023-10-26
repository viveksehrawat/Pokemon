//
//  PokemonListViewModelTests.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 26/10/23.
//


import XCTest
@testable import Pokemon

class PokemonListViewModelTests: XCTestCase {

    var viewModel: PokemonListViewModel!
    var mockUseCase: MockListUseCase!

    override func setUp() {
        super.setUp()
        mockUseCase = MockListUseCase()
        viewModel = PokemonListViewModel(useCase: mockUseCase)
    }

    override func tearDown() {
        super.tearDown()
    }

    func testLoad_Success() async throws {
        // Set up the mock data for a successful load
        mockUseCase.page = PokemonListMockData.pokemonPage
        mockUseCase.detail = PokemonDetailMockData.domainPokemonDetail

        await viewModel.load()

        // Create an expectation for waiting
        let expectation = XCTestExpectation(description: "Loading completed")
        
        // Wait for a maximum of 5 seconds
        let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)
        print("*************", viewModel.filteredPokemon.count)
       
        XCTAssertTrue(viewModel.filteredPokemon.count == 20)

    }


    func testLoad_Failure() async throws {
        // Set up the mock data for a successful load
        mockUseCase.error = NSError(domain: "Failed_Error", code: 0)

        await viewModel.load()

        print("*************", viewModel.filteredPokemon.count)
       
        XCTAssertTrue(viewModel.filteredPokemon.count == 0)

    }

    // Add more test cases for other scenarios as needed

}
