//
//  CharacterServiceAPI.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 09/11/2022.
//


import Foundation
import ProgressHUD

// MARK: - Vars
var limit = 0
var characterNumber = 0

protocol CharactersList {
    func getCharachters(completion: @escaping (Result<BasicDataResponse<[Character]>?, NSError>) -> Void)
    func getComics(id : Int, name: String, completion: @escaping (Result<BasicDataResponse<[ResultData]>?, NSError>) -> Void)
    func getSearchResult(nameStartsWith: String, completion: @escaping (Result<BasicDataResponse<[Character]>?, NSError>) -> Void)
}
//MARK:- Requests
class CharactersServiceAPI: BaseAPI<CharactersService>, CharactersList {
    func getSearchResult(nameStartsWith: String, completion: @escaping (Result<BasicDataResponse<[Character]>?, NSError>) -> Void) {
        ProgressHUD.show()
        characterNumber += 10
        self.fetchData(target: .getSearchResult(nameStartsWith: nameStartsWith), responseClass: [Character].self) {  (result) in
            
            completion(result)
        }
    }
    
    
    //MARK:- Requests
    func getComics(id: Int, name: String, completion: @escaping (Result<BasicDataResponse<[ResultData]>?, NSError>) -> Void) {
        ProgressHUD.show()
        self.fetchData(target: .getCollections(characterID: id,collectionName: name), responseClass: [ResultData].self) { (result) in
            
            completion(result)
        }
    }
    //MARK:- Requests
    
    func getCharachters(completion: @escaping (Result<BasicDataResponse<[Character]>?, NSError>) -> Void) {
        ProgressHUD.show()
        limit += 10
        self.fetchData(target:.getCharachters, responseClass: [Character].self) { (result) in
            
            completion(result)
        }
    }
}
