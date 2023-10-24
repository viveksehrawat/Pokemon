//
//  PropertyWrapperTests.swift
//  PokemonTests
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import Foundation
import XCTest

@testable import Pokemon

class PropertyWrapperTests: XCTestCase {

    func testSortedWrapper() {
        @Sorted(comparator: <) var numbers = [5, 4, 3, 2, 1]
        XCTAssertTrue(numbers == [1, 2, 3, 4, 5])
        @Sorted(comparator: <) var someNumbers = [3, 2, 1, 4, 5]
        XCTAssertTrue(numbers == someNumbers)

    }
}
