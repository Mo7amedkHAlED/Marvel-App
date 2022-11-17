//
//  CharactersService.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 09/11/2022.
//

import Foundation
import Alamofire

enum CharactersService {
    case getCharachters
    case getCollections(characterID: Int, collectionName: String)
    case getSearchResult(nameStartsWith: String)
}
extension CharactersService: TargetType {
    // This is the base URL we'll be using, typically our server.
    var baseURL: String {
        let serverURL = "https://gateway.marvel.com/v1/public/"
        guard let url = URL(string: serverURL) else { fatalError("wrong baseURL in Route") }
        let urlString: String = "\(url)"
        return urlString
    }
    
    // This is the path of each operation that will be appended to our base URL.
    var path: String {
        let ts = Int(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(ts)\(privateKey)\(publicKey)")
        switch self {
        case .getCharachters:
            return "characters?ts=\(ts)&limit=\(limit)&apikey=\(publicKey)&hash=\(hash)"
        case .getCollections(let characterID, let name):
            return "characters/\(characterID)/\(name)?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        case .getSearchResult(let nameStart):
            return "characters?nameStartsWith=\(nameStart)&limit=\(characterNumber)&ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"

        }
    }
    
    // Here we specify which method our calls should use.
    var method: HTTPMethod {
        switch self {
        case .getCharachters, .getCollections:
            return .get
        case .getSearchResult(_):
            return .get
        }
    }
    
    // Here we specify body parameters, objects, files etc.
    // or just do a plain request without a body.
    var task: Task {
        switch self {
        case .getCharachters:
            return .requestPlain
        case .getCollections:
            return .requestPlain
        case .getSearchResult(_):
            return .requestPlain
        }
    }
    
    // These are the headers that our service requires.
    var headers: [String: String]? {
        return ["accept": "application/json"]
    }
    
    // This is sample return data that you can use to mock and test your services,
    var sampleData: Data {
        return Data()
    }
}
