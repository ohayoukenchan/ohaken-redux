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
        let storeState = createCatState()

        let dispatchClosure: @MainActor @Sendable (CatAction) async -> Void = { [weak self] newAction in
            guard let self else { return }
            await self.dispatch(newAction)
        }

        await middleware.handleAction(
            action: action,
            state: storeState,
            dispatch: dispatchClosure
        )

        // middleware の処理が完了した後にリデューサーを実行
        catReducer(action: action, state: storeState)
    }

    func setCat(_ cat: Cat) {
        self.cat = cat
    }

    func setLoadingState(_ loadingState: LoadingState) {
        self.loadingState = loadingState
    }

    private func createCatState() -> CatStoreState {
        CatStoreState(
            cat: cat
        )
    }
}
