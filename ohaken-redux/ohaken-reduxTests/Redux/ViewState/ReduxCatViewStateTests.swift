//
//  ReduxCatViewState.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/24.
//  
//
import Testing

@testable import ohaken_redux

@Suite("ReduxCatViewStateTests")
@MainActor
struct ReduxCatViewStateTests {
    @Test("CatStoreの状態がReduxCatViewStateに反映される")
    func testStateBinding() async throws {
        let mockDispatcher = MockDispatcher()
        let viewState = ReduxCatViewState(actionDispatcher: mockDispatcher)
        let mockCat = createMockCat()

        CatStore.shared.apply(state: .init(cat: mockCat, loadingState: .success))

        #expect(viewState.cat == mockCat)
        #expect(viewState.loadingState == .success)
    }

    @Test("dispatchがActionDispatcherに渡される")
    func testDispatch() async throws {
        let mockDispatcher = MockDispatcher()
        let viewState = ReduxCatViewState(actionDispatcher: mockDispatcher)

        viewState.dispatch(.fetchCat)

        try await Task.sleep(nanoseconds: 1_000_000)

        #expect(mockDispatcher.dispatchedActions.contains(.fetchCat))
    }
}

