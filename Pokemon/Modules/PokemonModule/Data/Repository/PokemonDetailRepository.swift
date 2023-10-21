//
//  PokemonDetailRepository.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 21/10/23.
//

import Foundation

class PokemonDetailRepositoryImpl: IPokemonDetailRepository {

    private let networkManager: INetworkManager
    
    init(networkManager: INetworkManager) {
        self.networkManager = networkManager
    }
    
    func fetchPokemonDetail(for name: String) async throws -> PokemonDetail {
        let path = "/api/v2/pokemon/\(name)"
        let request = NetworkRequest(path: path, method: .get)
        do{
            let response = try await networkManager.request(request: request, responseType: PokemonDetailDTO.self)
            return response.toDomain()
        } catch{
            throw error
        }
    }
    
//    func fetchPokemonDescription(for id: String) async throws -> PokemonDescription {
//        <#code#>
//    }
//    
//    func fetchPokemonWeakness(for id: String) async throws -> PokemonWeakness {
//        <#code#>
//    }
//    
//    func fetchPokemonEvolutionCahin(for url: String) async throws -> PokemonWeakness {
//        <#code#>
//    }
}

//
//final class DefaultPokemonDetailRepository {
//
//    private let dataTransferService: DataTransferService
//
//    init(dataTransferService: DataTransferService) {
//        self.dataTransferService = dataTransferService
//    }
//}
//
//extension DefaultPokemonDetailRepository: PokemonDetailRepository {
//
//    func fetchPokemonDescription(id: Int,
//                                 completion: @escaping (Result<PokemonDescription, Error>) -> Void) -> Cancellable? {
//
//        let task = RepositoryTask()
//
//        let endpoint = APIEndpoints.getPokemonDescription(with: id)
//        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
//            switch result {
//            case .success(let responseDTO):
//                completion(.success(responseDTO.toDomain()))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//
//        return task
//    }
//
//    func fetchPokemonDetail(name: String,
//                            completion: @escaping (Result<PokemonDetail, Error>) -> Void) -> Cancellable? {
//
//        let task = RepositoryTask()
//
//        let endpoint = APIEndpoints.getPokemonDetail(with: name)
//
//        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
//            switch result {
//            case .success(let responseDTO):
//                completion(.success(responseDTO.toDomain()))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//
//        return task
//    }
//
//    func fetchPokemonWeakness(id: Int,
//                              completion: @escaping (Result<PokemonWeakness, Error>) -> Void) -> Cancellable? {
//
//        let task = RepositoryTask()
//
//        let endpoint = APIEndpoints.getPokemonWeakness(with: id)
//
//        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
//            switch result {
//            case .success(let responseDTO):
//                completion(.success(responseDTO.toDomain()))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//
//        return task
//    }
//
//    func fetchPokemonEvolutionChain(url: String, completion: @escaping (Result<EvolutionChain, Error>) -> Void) -> Cancellable? {
//        let task = RepositoryTask()
//
//        let endpoint = APIEndpoints.getPokemonEvolutionChain(with: url)
//        task.networkTask = self.dataTransferService.request(with: endpoint) { result in
//            switch result {
//            case .success(let responseDTO):
//                completion(.success(responseDTO.toDomain()))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//
//        return task
//    }
//
//}
