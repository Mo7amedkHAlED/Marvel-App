//
//  File.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 25/10/2022.
//

import UIKit
import RealmSwift

// MARK: - Home Characters MODEL
struct Character: Codable{
    var id: Int
    var name: String
    var description: String
    var inFavorites: Bool? = false
    var thumbnail : Thumbnail
    var urls: [[String: String]]
}
               
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

