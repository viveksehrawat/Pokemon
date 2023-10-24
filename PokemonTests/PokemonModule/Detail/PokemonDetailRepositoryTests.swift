//
//  PokemonDetailRepositoryTests.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import XCTest
@testable import Pokemon

final class PokemonDetailRepositoryTests: XCTestCase {

   
    var detailRepository: IPokemonDetailRepository!
    var mockNetworkManager: MockNetworkManager!

       override func setUpWithError() throws {
      
       }

       override func tearDownWithError() throws {
           detailRepository = nil
           mockNetworkManager = nil
       }

       // Test case 1: Successful network request for Pokemon detail
       func testFetchPokemonDetail_Success() async throws {
           // Arrange
           let happyNetworkManager = MockHappyNetworkManager()
           happyNetworkManager.response = PokemonDetailMockData.pokemonDetailResponse
           detailRepository = PokemonDetailRepositoryImpl(networkManager: happyNetworkManager)

           // Act
           let fetchedPokemonDetail = try await detailRepository.fetchPokemonDetail(for: "1")

           // Assert
           XCTAssertEqual(fetchedPokemonDetail.name, "venusaur")
       }

       // Test case 2: Successful network request for Pokemon description
       func testFetchPokemonDescription_Success() async throws {
           // Arrange
           let happyNetworkManager = MockHappyNetworkManager()
           happyNetworkManager.response = PokemonDescMockData.pokemonDescResponse
           detailRepository = PokemonDetailRepositoryImpl(networkManager: happyNetworkManager)

           // Act
           let fetchedDescription = try await detailRepository.fetchPokemonDescription(for: 25)

           // Assert
           XCTAssertEqual(fetchedDescription.id, 1)
       }

       // Test case 3: Successful network request for Pokemon weakness
       func testFetchPokemonWeakness_Success() async throws {
           // Arrange
           let happyNetworkManager = MockHappyNetworkManager()
           happyNetworkManager.response = PokemonWeaknessMockData.pokemonWeaknessResponse
           detailRepository = PokemonDetailRepositoryImpl(networkManager: happyNetworkManager)

           // Act
           let fetchedWeakness = try await detailRepository.fetchPokemonWeakness(for: 4)

           // Assert
           XCTAssertEqual(fetchedWeakness.name, "normal")
       }
    
    // Test case 4: Successful network request for Pokemon Evolution
    func testFetchPokemonEvolution_Success() async throws {
        // Arrange
        let happyNetworkManager = MockHappyNetworkManager()
        happyNetworkManager.response = PokemonEvolutionMockData.pokemonEvolutionResponse
        detailRepository = PokemonDetailRepositoryImpl(networkManager: happyNetworkManager)

        // Act
        let fetchedData = try await detailRepository.fetchPokemonEvolutionChain(for: "")

        // Assert
        XCTAssertEqual(fetchedData.chain.species.name, "bulbasaur")
    }

       // Test case 5: Network failure with an error
       func testFetchPokemonDetail_Failure() async throws {
           // Arrange
           let sadNetworkManager = MockSadNetworkManager()
           sadNetworkManager.error = NetworkError.invalidResponse
           detailRepository = PokemonDetailRepositoryImpl(networkManager: sadNetworkManager)

           // Act & Assert
           do {
               _ = try await detailRepository.fetchPokemonDetail(for: "charizard")
               XCTFail("Expected an error, but the request succeeded.")
           } catch {
               XCTAssertTrue(error is NetworkError)
           }
       }
  
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
