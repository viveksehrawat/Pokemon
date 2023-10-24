//
//  URLREQUESTGENERATORTESTS.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import Foundation

import XCTest
@testable import Pokemon

final class URLRequestGeneratorTests: XCTestCase {

    var requestGenerator: IURLRequestGenerator!
    
    override func setUpWithError() throws {
        super.setUp()
        requestGenerator = URLRequestGenerator()
    }

    override func tearDown()  {
        requestGenerator = nil
        super.tearDown()
    }

    func testURLResquest(){
        let request = NetworkRequest(path: "/api/v2/pokemon", method: .get, headerParamaters: ["Content-Type":"application/json"])
        do {
            let urlRequest = try requestGenerator.createURLRequest(using: request)
            XCTAssertEqual(urlRequest.url?.scheme, "https")
            XCTAssertEqual(urlRequest.url?.host, "pokeapi.co")
            XCTAssertEqual(urlRequest.url?.path, "/api/v2/pokemon")
            XCTAssertEqual(urlRequest.url, URL(string: "https://pokeapi.co/api/v2/pokemon?"))
            XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
            XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["Content-Type":"application/json"])
            XCTAssertNil(urlRequest.httpBody)
        } catch{
            XCTFail("Request Failure not expected")
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
