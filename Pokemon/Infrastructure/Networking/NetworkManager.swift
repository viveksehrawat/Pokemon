//
//  NetworkManager.swift
//  MovieList
//
//  Created by Vivek Sehrawat on 22/09/23.
//

import Foundation

protocol INetworkManager {
    func request<T: Decodable>(request: INetworkRequest, responseType: T.Type) async throws -> T
}

class NetworkManager: INetworkManager{
    
    private let session: URLSession
    private let requestGenerator: IURLRequestGenerator
    
    init(session: URLSession, requestGenerator: IURLRequestGenerator) {
        self.session = session
        self.requestGenerator = requestGenerator
    }
    
    convenience init(session: URLSession = .shared) {
        self.init(session: session, requestGenerator: URLRequestGenerator())
    }
    
    private let certificates: [Data] = {
        let url = Bundle.main.url(forResource: "raw.githubusercontent.com", withExtension: "cer")!
        let data = try! Data(contentsOf: url)
        return [data]
      }()
    
    func request<T>(request: INetworkRequest, responseType: T.Type) async throws -> T where T : Decodable {
        guard let urlRequest = try? requestGenerator.createURLRequest(using: request) else {
            throw NetworkError.invalidRequest
        }
        print("URL =========== \(urlRequest.url)")
        let (data, response) = try await session.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.badRequest
        }
        do {
           
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        }catch{
            throw error
        }
    }
}
