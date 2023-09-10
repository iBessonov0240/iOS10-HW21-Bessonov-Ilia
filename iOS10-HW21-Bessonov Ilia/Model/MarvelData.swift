//
//  MarvelData.swift
//  iOS10-HW21-Bessonov Ilia
//
//  Created by i0240 on 30.08.2023.
//

import Foundation

struct MarvelData: Codable {
    var code: Int
    var data: MarvelResults
}

struct MarvelResults: Codable {
    var results: [Results]
}

struct Results: Codable {
    var title: String? = ""
    var modified: String? = ""
    var thumbnail: [Thumbnail]?
    var description: String? = ""
}

struct Thumbnail: Codable {
    let path: String
    let imageExtension: String

    private enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        path = try container.decode(String.self, forKey: .path)
        imageExtension = try container.decode(String.self, forKey: .imageExtension)
    }
}
