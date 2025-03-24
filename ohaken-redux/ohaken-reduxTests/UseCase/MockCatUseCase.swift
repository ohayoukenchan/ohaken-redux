//
//  MockCatUseCase.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/24.
//
//
import Foundation

@testable import ohaken_redux

@MainActor
final class MockCatUseCase: CatUseCase {
    var mockCat: Cat?
    var mockError: Error?

    func fetchCat() async throws ->
        Cat {
        if let mockError {
            throw mockError
        }
        return mockCat ?? createMockCat()
    }
}
