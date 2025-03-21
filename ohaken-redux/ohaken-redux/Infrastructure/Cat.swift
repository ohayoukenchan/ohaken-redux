//
//  Cat.swift
//  ohaken-redux
//
//  Created by ohayoukenchan on 2025/03/21.
//  
//

import Foundation

struct Cat: Codable, Equatable {
    let id: String
    let tags: [String]
    let createdAt: String
    let url: String
    let mimetype: String

    enum CodingKeys: String, CodingKey {
        case id
        case tags
        case createdAt = "created_at"
        case url
        case mimetype
    }
}
