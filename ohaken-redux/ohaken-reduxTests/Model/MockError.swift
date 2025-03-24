//
//  MockError.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/24.
//  
//
import Foundation

func createMockError() -> Error {
    NSError(domain: "MockError", code: 0, userInfo: nil)
}
