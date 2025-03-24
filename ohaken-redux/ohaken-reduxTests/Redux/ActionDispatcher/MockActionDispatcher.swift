//
//  MockActionDispatcher.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/24.
//  
//
@testable import ohaken_redux

@MainActor
final class MockDispatcher: ActionDispatcher {
    typealias ActionType = CatAction

    private(set) var dispatchedActions: [CatAction] = []

    func dispatch(_ action: CatAction) async {
        dispatchedActions.append(action)
    }
}
