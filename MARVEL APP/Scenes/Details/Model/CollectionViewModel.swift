//
//  CollectionViewModel.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 31/10/2022.
//

import Foundation
// MARK: -  create Model To get Data from API
struct CharacterDetailsModel: Codable {
    let id: Int
    let title: String
    let thumbnail: ThumbnailPath
}

struct ThumbnailPath: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
