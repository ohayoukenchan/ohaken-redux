//
//  CatUseCase.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/24.
//
//
protocol CatUseCase {
    func fetchCat() async throws -> Cat
}

