//
//  PokemonListViewModel.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import Foundation

class PokemonListViewModel: LoadableObject{
    
    private let useCase: IPokemonListUseCase
    typealias Output = [Pokemon]

    @Published var state = LoadingState<Output>.idle
    @Published var pokemons: [Pokemon] = [Pokemon]()
    @Published var searchText = ""
    @Published var selectedPokemonIndex = 0
    @Sorted(by: \.id) var detailItems: [PokemonDetail] = []

    

    init(useCase: IPokemonListUseCase) {
        self.useCase = useCase
    }
    
    var filteredPokemon : [Pokemon] {
        return searchText == "" ? pokemons : pokemons.filter { $0.name.contains(searchText.lowercased())
        }
    }
    
    // Get the index of a pokemon
    func getPokemonIndex(pokemon: Pokemon) -> Int {
        if let index = self.pokemons.firstIndex(of: pokemon){
            return index + 1
        }
        return 0
    }
    
    @MainActor
    func load(){
        state = .loading
        Task{
            do {
                let result = try await useCase.fetchPokemonList()
                 await fetchPokemonDetails(for: result)
//                state = .loaded(result)
//                pokemons = result
            } catch {
                state = .failed(error)
                print(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    private func fetchPokemonDetails(for page: PokemonPage) async   {
        let pokemonList = page.pokemons
        /*
        do {
        // Create a task group to fetch Pokemon details concurrently
            try await withThrowingTaskGroup(of: PokemonDetail.self) { taskGroup in
            for pokemon in pokemonList {
                taskGroup.addTask {
                    let name = pokemon.name.lowercased()
                    let itemDetail = try await self.useCase.fetchPokemonDetail(for: name)
                    print(itemDetail.name)
                    return itemDetail

                }
            }

            // Wait for all tasks to complete
                for try await result in taskGroup {
                    // You can access the result if needed
                    self.detailItems.append(result)
                }
            }
        } catch {
            print("Error loading Pokemon details: \(error.localizedDescription)")
            state = .failed(error)
            }
        
        */
        pokemons = pokemonList
        state = .loaded(pokemonList)
//        self.appendPage(page, details: self.detailItems)
    }


   

//    func fetchPokemonDetails(for list: [Pokemon]){
//        Task{
//            do {
//                let result = try await useCase.fetchPokemonList()
//                state = .loaded(result)
//                pokemons = result
//            } catch {
//                state = .failed(error)
//                print(error.localizedDescription)
//            }
//        }
//    }
    
}



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
