//
//  PokemonRepositoryTests.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import XCTest
@testable import Pokemon

final class PokemonRepositoryTests: XCTestCase {

    var pokemonRepository: IPokemonRepository! //This class will be tested
    var mockNetworkManager: MockNetworkManager! // D.I
    
    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
        pokemonRepository = nil
        mockNetworkManager = nil
    }
    
    func test_PokemonRepository_NetworkSuccessWithValidData() async throws {
        // Arrange

        let happyNetworkManager = MockHappyNetworkManager()
        happyNetworkManager.response = PokemonListMockData.pokemonResponse
       
        pokemonRepository = PokemonRepositoryImpl(networkManager: happyNetworkManager)

        // Act
        let pokemonPage = try await pokemonRepository.fetchPokemonsFromNetwork()
        let pokemons = pokemonPage.pokemons

        // Assert
        XCTAssertEqual(pokemons.count, 20) // or the expected count based on the mock data
    }
    
    func test_PokemonRepository_NetworkFailureWithError() async throws {
        // Arrange
        let sadNetworkManager = MockSadNetworkManager()
        pokemonRepository = PokemonRepositoryImpl(networkManager: sadNetworkManager)
        sadNetworkManager.error = NetworkError.invalidResponse
        // Act & Assert
        do {
            _ = try await pokemonRepository.fetchPokemonsFromNetwork()
            XCTFail("Expected an error, but the request succeeded.")
        } catch {
            // Assert that the error is of the expected type (NetworkError)
            XCTAssertTrue(error is NetworkError)
            // Optionally, check the specific error code or description, if applicable.
            // XCTAssertEqual((error as? NetworkError)?.errorCode, NetworkError.invalidResponse.errorCode)
        }
    }
    
    func test_PokemonRepository_ParsingError() async throws {
        // Arrange
        let invalidData = Data() // Invalid data that can't be parsed
        let networkManager = MockHappyNetworkManager()
        pokemonRepository = PokemonRepositoryImpl(networkManager: networkManager)
        
        // Act & Assert
        do {
            _ = try await pokemonRepository.fetchPokemonsFromNetwork()
            XCTFail("Expected an error, but the request succeeded.")
        } catch {
            // Assert that the error is of the expected type (NetworkError or a custom parsing error)
            XCTAssertTrue(error is NetworkError)
            // Optionally, check the specific error code or description, if applicable.
            // XCTAssertEqual((error as? NetworkError)?.errorCode, NetworkError.invalidResponse.errorCode)
        }
    }


    func testMovieService_Stub_Success()  async throws{
        //Arrange
        let happyNetworkManager = HappyNetworkManagerStub()
        pokemonRepository = PokemonRepositoryImpl(networkManager: happyNetworkManager)
        // Act
        let fetchedPokemonPage = try await pokemonRepository.fetchPokemonsFromNetwork()
        // Assert
        XCTAssertNotNil(fetchedPokemonPage) // Check that the result is not nil
    }
    
    func testPokemonRepository_NetworkFailure() async throws {
        // Arrange
        let sadNetworkManager = SadNetworkManagerStub()
        let pokemonRepository = PokemonRepositoryImpl(networkManager: sadNetworkManager)
        
        // Act & Assert
        do {
            _ = try await pokemonRepository.fetchPokemonsFromNetwork()
            XCTFail("Expected an error, but the request succeeded.")
        } catch {
            // Assert that the error is of the expected type (NetworkError)
            XCTAssertTrue(error is NetworkError)
            // Optionally, check the specific error code or description, if applicable.
            // XCTAssertEquals((error as? NetworkError)?.errorCode, NetworkError.invalidResponse.errorCode)
        }
    }

    
    func test_Pokemon_Stub_Pokemon_Count()  async throws{
        //Arrange
        let happyNetworkManager = HappyNetworkManagerStub()
        pokemonRepository = PokemonRepositoryImpl(networkManager: happyNetworkManager)
        // Act
        let pokemonPage = try await pokemonRepository.fetchPokemonsFromNetwork()
        let pokemons = pokemonPage.pokemons

        // Assert
        XCTAssertEqual(pokemons.count, 20)
    }

}


// Mark: - Stubs
class HappyNetworkManagerStub: INetworkManager {
    func request<T: Decodable>(request: INetworkRequest, responseType: T.Type) async throws -> T where T : Decodable {
        return PokemonListMockData.pokemonResponse as! T
    }
}

class SadNetworkManagerStub: INetworkManager {
        func request<T: Decodable>(request: INetworkRequest, responseType: T.Type) async throws -> T where T : Decodable {
            throw NetworkError.invalidResponse
    }
}


// Mark: - Mock
class MockHappyNetworkManager: INetworkManager {
    var response: Decodable?
    var error: Error?
    var serviceCalled: Int = 0
    
    func request<T: Decodable>(request: INetworkRequest, responseType: T.Type) async throws -> T where T : Decodable {

        serviceCalled += 1
        if let response = response {
            return response as! T
        } else {
            throw NetworkError.invalidResponse
        }
    }
}

// Mark: - Mock
class MockSadNetworkManager: INetworkManager {
    var response: Decodable?
    var error: Error?
    
    func request<T: Decodable>(request: INetworkRequest, responseType: T.Type) async throws -> T where T : Decodable {

        if let response = response {
            return response as! T
        } else {
            throw NetworkError.invalidResponse
        }
    }
}
