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
    var description: String? = ""
}
