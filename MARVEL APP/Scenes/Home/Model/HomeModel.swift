//
//  File.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 25/10/2022.
//

import UIKit

// MARK: - Home MODEL
//
class MarvelHome{
    let image: String
    let text : String
    var des: String

    init(image: String, text: String, des : String ) {
        self.image = image
        self.text = text
        self.des = des
    }
}

// MARK: - API Model
struct APIResult : Codable{
    var data: APICharacterData
    
}

// MARK: - APICharacterData Model
struct APICharacterData: Codable{
    var count: Int
    var results: [Character]
}
//
// MARK: - Home Characters MODEL

struct Character: Codable{
    var id: Int
    var name: String
    var description: String
    var thumbnail : Thumbnail
    var urls: [[String: String]]
}
               
struct Thumbnail: Codable {
    let path: String
    let thumbnailExtension: Extension

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}
enum Extension: String, Codable {
    case gif = "gif"
    case jpg = "jpg"
}

