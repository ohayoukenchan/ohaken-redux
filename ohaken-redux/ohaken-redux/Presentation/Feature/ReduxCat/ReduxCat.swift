//
//  ReduxCat.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/21.
//
//
import SwiftUI

struct ReduxCat: View {
    @ObservedObject private var viewState: ReduxCatViewState<CatActionDispatcher>

    public init(viewState: ReduxCatViewState<CatActionDispatcher>) {
        self.viewState = viewState
    }

    var body: some View {
        VStack {
            switch viewState.loadingState {
            case .idle:
                Text("idle")
            case .loading:
                ProgressView()
            case .success:
                if let cat = viewState.cat {
                    AsyncImage(url: URL(string: cat.url))
                } else {
                    Text("No cat")
                }
            case .error(let message):
                Text("\(message)")
            }
        }
        .task {
            viewState.dispatch(.fetchCat)
        }
    }
}

#Preview {
    ReduxCat(viewState: ReduxCatViewState(actionDispatcher: CatActionDispatcher()))
}

