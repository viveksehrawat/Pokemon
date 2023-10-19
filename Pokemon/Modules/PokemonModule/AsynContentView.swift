//
//  AsynContentView.swift
//  Pokemon
//
//  Created by Vivek Sehrawat on 19/10/23.
//

import SwiftUI

enum LoadingState<Value> {
    case idle
    case loading
    case failed(Error)
    case loaded(Value)
}

protocol LoadableObject: ObservableObject {
    associatedtype Output
    var state: LoadingState<Output> { get }
    func load()
}

struct AsyncContentView<Source: LoadableObject, Content: View>: View {
    @ObservedObject var source: Source
    var content: (Source.Output) -> Content
    
    init(source: Source,
         @ViewBuilder content: @escaping (Source.Output) -> Content) {
        self.source = source
        self.content = content
    }
    var body: some View {
        switch source.state {
        case .idle:
            Color.clear.onAppear(perform: source.load)
        case .loading:
            ProgressView()
        case .failed(let error):
            ErrorView(error: error, retryHandler: source.load)
        case .loaded(let output):
            content(output)
        }
    }
}

struct ErrorView: View {
    let error: Error
    let retryHandler: () -> Void
    
    var body: some View {
        VStack {
            Text("Error: \(error.localizedDescription)")
            Button("Retry", action: retryHandler)
        }
    }
}
