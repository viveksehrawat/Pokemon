//
//  Sorted.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 24/10/23.
//

import Foundation

@propertyWrapper
struct Sorted<Value> {
    
    var wrappedValue: [Value] {
        didSet {
            wrappedValue.sort(by: comparator)
        }
    }
    
    typealias Comparator = (Value, Value) -> Bool
    
    private let comparator: Comparator
    
    init(wrappedValue: [Value] = [], comparator: @escaping Comparator) {
        self.wrappedValue = wrappedValue.sorted(by: comparator)
        self.comparator = comparator
    }
}

extension Sorted: Equatable where Value: Equatable {
    
    static func == (lhs: Sorted<Value>, rhs: Sorted<Value>) -> Bool {
        return lhs.wrappedValue == rhs.wrappedValue
    }
}

extension Sorted where Value: Comparable {
    
    init(wrappedValue: [Value] = [], ascending: Bool = true) {
        self.init(
            wrappedValue: wrappedValue,
            comparator: ascending ? { $0 < $1 } : { $0 > $1 }
        )
    }
}

extension Sorted {
    
    init<C: Comparable>(wrappedValue: [Value] = [], by keyPath: KeyPath<Value, C>, ascending: Bool = true) {
        self.init(
            wrappedValue: wrappedValue,
            comparator: ascending ? { $0[keyPath: keyPath] < $1[keyPath: keyPath] } : { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
        )
    }
}
