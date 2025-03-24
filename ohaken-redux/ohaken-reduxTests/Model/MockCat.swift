//
//  MockCat.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/24.
//
//
@testable import ohaken_redux

func createMockCat(
    id: String = "1",
    tags: [String] = ["tag1"],
    createdAt: String = "2025-03-24T00:00:00Z",
    url: String = "https://cataas.com/cat/1",
    mimetype: String = "image/jpeg"
) -> Cat {
    Cat(
        id: id,
        tags: tags,
        createdAt: createdAt,
        url: url,
        mimetype: mimetype
    )
}
