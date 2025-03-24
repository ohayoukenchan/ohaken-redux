//
//  CatStore.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2024/11/21.
//
//
import Combine
import SwiftUI

@MainActor
final class CatStore: ObservableObject, Dispatchable {
    typealias ActionType = CatAction

    @Published private(set) var cat: Cat?

    @Published private(set) var loadingState = LoadingState.idle

    private let middleware: CatMiddleware

    public static let shared = CatStore(
        middleware: MiddleWareFactory.createCatMiddleware()
    )

    init(middleware: CatMiddleware) {
        self.middleware = middleware
    }

    func dispatch(_ action: CatAction) async {
        await recursiveDispatch(action)
    }

    private func recursiveDispatch(_ newAction: CatAction) async {
        let currentState = createCatState()
        let newState = catReducer(action: newAction, state: currentState)
        apply(state: newState)

        await middleware.handleAction(
            action: newAction,
            state: newState,
            dispatch: { await self.recursiveDispatch($0) }
        )
    }

    func createCatState() -> CatStoreState {
        CatStoreState(
            cat: cat,
            loadingState: loadingState
        )
    }

    func apply(state: CatStoreState) {
        self.cat = state.cat
        self.loadingState = state.loadingState
    }


}
