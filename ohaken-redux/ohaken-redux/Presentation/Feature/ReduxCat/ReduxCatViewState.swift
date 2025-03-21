//
//  ReduxCatViewState.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/21.
//
//
import SwiftUI

@MainActor
final class ReduxCatViewState<D: ActionDispatcher>: ObservableObject where D.ActionType == CatAction {
    private let actionDispatcher: D

    @Published var cat: Cat?

    @Published var loadingState: LoadingState = .idle

    public init(actionDispatcher: D) {
        self.actionDispatcher = actionDispatcher
        CatStore.shared.$cat.assign(to: &$cat)

        CatStore.shared.$loadingState.assign(to: &$loadingState)
    }

    public func dispatch(_ action: CatAction) {
        Task {
            await actionDispatcher.dispatch(action)
        }
    }
}
