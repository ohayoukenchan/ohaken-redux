//
//  CatMiddlewareTests.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/24.
//
//
import Testing

@testable import ohaken_redux

@Suite("CatMiddlewareTests")
struct CatMiddlewareTests {
    @Test("fetchCatが成功したとき_setCatを実行する")
    @MainActor
    func fetchCat() async throws {
        var dispatchedActions: [CatAction] = []

        let mockUseCase = MockCatUseCase()

        let result = createMockCat()

        mockUseCase.mockCat = result

        // Arrange: CatMiddlewareImplを生成
        let middleware = CatMiddlewareImpl(useCase: mockUseCase)

        // Act: handleActionを実行
        await middleware.handleAction(
            action: .fetchCat,
            state: CatStoreState(
                cat: nil
            ),
            dispatch: { action in
                dispatchedActions.append(action)
            }
        )

        // Assert: dispatchされたAction
        #expect(dispatchedActions.count == 3)

        #expect(dispatchedActions[0] == .setLoadingState(state: .loading))
        #expect(dispatchedActions[1] == .setCat(cat: result))
        #expect(dispatchedActions[2] == .setLoadingState(state: .success))
    }

    @Test("fetchCatが失敗したとき_setLoadingStateをerrorで実行する")
    @MainActor
    func fetchCatError() async throws {
        var dispatchedActions: [CatAction] = []

        let mockUseCase = MockCatUseCase()

        let error = createMockError()

        mockUseCase.mockError = error

        // Arrange: CatMiddlewareImplを生成
        let middleware = CatMiddlewareImpl(useCase: mockUseCase)

        // Act: handleActionを実行
        await middleware.handleAction(
            action: .fetchCat,
            state: CatStoreState(
                cat: nil
            ),
            dispatch: { action in
                dispatchedActions.append(action)
            }
        )

        // Assert: dispatchされたAction
        #expect(dispatchedActions.count == 2)

        #expect(dispatchedActions[0] == .setLoadingState(state: .loading))
        #expect(dispatchedActions[1] == .setLoadingState(state: .error("データの取得に失敗しました")))
    }
}

