//
//  CharacterServiceAPI.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 09/11/2022.
//


import Foundation
// MARK: - Vars
var limit = 0
var characterNumber = 0

protocol UsersAPIProtocol {
    
    func getCharachters(completion: @escaping (Result<BasicDataResponse<[CharactersListModel]>?, NSError>) -> Void)
    
    func getComics(id : Int, name: String, completion: @escaping (Result<BasicDataResponse<[CharacterDetailsModel]>?, NSError>) -> Void)
    
    func getSearchResult(nameStartsWith: String, completion: @escaping (Result<BasicDataResponse<[CharactersListModel]>?, NSError>) -> Void)
    
}

//MARK:- Requests
class CharactersServiceAPI: BaseAPI<CharactersService>, UsersAPIProtocol {
    //MARK:- Requests
    func getSearchResult(nameStartsWith: String, completion: @escaping (Result<BasicDataResponse<[CharactersListModel]>?, NSError>) -> Void) {
        
        if nameStartsWith.isEmpty == false{
            characterNumber += 10
            self.fetchData(target: .getSearchResult(nameStartsWith: nameStartsWith), responseClass: [CharactersListModel].self) {  (result) in
                
                completion(result)
            }
        }
    }
    
    
    //MARK:- Requests
    func getComics(id: Int, name: String, completion: @escaping (Result<BasicDataResponse<[CharacterDetailsModel]>?, NSError>) -> Void) {
        self.fetchData(target: .getCollections(characterID: id,collectionName: name), responseClass: [CharacterDetailsModel].self) { (result) in
            
            completion(result)
        }
    }
    //MARK:- Requests
    
    func getCharachters(completion: @escaping (Result<BasicDataResponse<[CharactersListModel]>?, NSError>) -> Void) {
        limit += 10
        self.fetchData(target:.getCharachters, responseClass: [CharactersListModel].self) { (result) in
            
            completion(result)
        }
    }
}
