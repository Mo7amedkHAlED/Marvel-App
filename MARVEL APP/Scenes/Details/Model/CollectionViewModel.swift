//
//  CollectionViewModel.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 31/10/2022.
//

import Foundation
// MARK: -  create Model To get Data from API
struct APICollectionResult : Codable{
    let data: APICollectionData
}
struct APICollectionData: Codable{
    let count: Int
    let results: [ResultData]
}

struct ResultData: Codable {
    let id: Int
    let title: String
    let thumbnail: ThumbnailPath
}
struct ThumbnailPath: Codable {
    let path: String
    let thumbnailExtension: ExtensionImagge

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
enum ExtensionImagge: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}
