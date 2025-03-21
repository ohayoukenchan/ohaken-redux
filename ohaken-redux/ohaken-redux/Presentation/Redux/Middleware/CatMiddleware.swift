//
//  CatMiddleware.swift
//  LayeredModule
//
//  Created by ohayoukenchan on 2025/01/28.
//
//
@MainActor
protocol CatMiddleware: AnyObject {
    func handleAction(
        action: CatAction,
        state: CatStoreState,
        dispatch: @escaping @MainActor @Sendable (CatAction) async -> Void
    ) async
}
