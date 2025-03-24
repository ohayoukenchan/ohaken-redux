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
        let currentState = createCatState()

        let dispatchClosure: @MainActor @Sendable (CatAction) async -> Void = { [weak self] newAction in
            guard let self else { return }
            await self.dispatch(newAction)
        }

        await middleware.handleAction(
            action: action,
            state: currentState,
            dispatch: dispatchClosure
        )

        // Reducerに新しいstateを生成させて反映する
        let newState = catReducer(action: action, state: currentState)
        CatStore.shared.apply(state: newState)
    }

    func apply(state: CatStoreState) {
        self.cat = state.cat
        self.loadingState = state.loadingState
    }

//    func setCat(_ cat: Cat) {
//        self.cat = cat
//    }
//
//    func setLoadingState(_ loadingState: LoadingState) {
//        self.loadingState = loadingState
//    }

    private func createCatState() -> CatStoreState {
        CatStoreState(
            cat: cat,
            loadingState: loadingState
        )
    }
}
