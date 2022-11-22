//
//  FavouriteViewModel.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 19/11/2022.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class FavouriteViewModel {
    // MARK: - Declare Realm
    let realm = try! Realm()
    private var favoriteModelSubject = PublishSubject<Results<CaractersModel>>()
    var favoriteModelObservable: Observable<Results<CaractersModel>> {
        return favoriteModelSubject
    }
    
    // MARK: - create method to get data from realm
    func fetchCaracterListDB() {
        let favList = realm.objects(CaractersModel.self)
        favoriteModelSubject.onNext(favList)
    }
    
    // MARK: - create method to delete data from realm
    func deteteItemFromRealm(row: Int){
        do {
            let favList = realm.objects(CaractersModel.self)
            try realm.write {
                realm.delete(favList[row])
                fetchCaracterListDB()
            }
        } catch {
            print("Error trying to delete object from realm database. \(error)")
        }
    }
    
}
