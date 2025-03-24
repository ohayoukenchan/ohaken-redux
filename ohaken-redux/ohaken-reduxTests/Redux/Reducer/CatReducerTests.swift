//
//  CatReducerTests.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/24.
//  
//
import Testing

@testable import ohaken_redux

@Suite("CatReducerTests")
struct CatReducerTests {
    @Test("setCatが成功する")
    func setCat() {
        let result = createMockCat()

        let initialState = CatStoreState(cat: nil)
        let newState = catReducer(action: .setCat(cat: result), state: initialState)

        #expect(newState.cat == result)
    }

    @Test("setLoadingStateが成功する")
    func setLoadingState() {
        let initialState = CatStoreState(cat: nil, loadingState: .idle)
        let newState = catReducer(action: .setLoadingState(state: .loading), state: initialState)

        #expect(newState.loadingState == .loading)
    }
}
