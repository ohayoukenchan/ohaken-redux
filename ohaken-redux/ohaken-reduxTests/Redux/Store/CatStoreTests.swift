//
//  CatStoreTests.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/24.
//  
//

import Testing

@testable import ohaken_redux

@Suite("CatStoreTests")
@MainActor
struct CatStoreTests {
    @Test("applyでstateが反映される")
    func testApply() {
        let store = CatStore.shared
        let mockCat = createMockCat()

        let state = CatStoreState(cat: mockCat, loadingState: .success)

        store.apply(state: state)

        #expect(store.cat == mockCat)
        #expect(store.loadingState == .success)
    }

    @Test("createCatStateが現在の状態を返す")
    func testCreateCatState() {
        let store = CatStore.shared
        let mockCat = createMockCat()

        store.apply(state: .init(cat: mockCat, loadingState: .loading))

        let state = store.createCatState()

        #expect(state.cat == mockCat)
        #expect(state.loadingState == .loading)
    }

    @Test("dispatchで猫取得成功のフローが動く")
    @MainActor
    func testDispatchSuccess() async throws {
        let useCase = MockCatUseCase()
        let mockCat = createMockCat()
        useCase.mockCat = mockCat

        let middleware = MockCatMiddleware(useCase: useCase)
        let store = CatStore(middleware: middleware)

        await store.dispatch(.fetchCat)

        #expect(store.cat == mockCat)
        #expect(store.loadingState == .success)
    }

    @Test("dispatchで猫取得失敗時にエラーがセットされる")
    @MainActor
    func testDispatchFailure() async {
        let useCase = MockCatUseCase()
        let error = createMockError()
        useCase.mockError = error

        let middleware = MockCatMiddleware(useCase: useCase)
        let store = CatStore(middleware: middleware)

        await store.dispatch(.fetchCat)

        #expect(store.cat == nil)
        #expect(store.loadingState == .error("データの取得に失敗しました"))
    }
}
