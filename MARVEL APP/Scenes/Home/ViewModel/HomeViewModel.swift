//
//  HomeViewModel.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 17/11/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class HomeViewModel {
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var CharacterModelSubject = PublishSubject<[CharactersListModel]>()
    
    var CharacterModelObservable: Observable<[CharactersListModel]> {
        return CharacterModelSubject
    }
    
    func fetchApiCharacterData() {
        loadingBehavior.accept(true)
        api.getCharachters {[weak self] (result) in
           guard let self = self else { return }
            self.loadingBehavior.accept(false)
            switch result {
                
            case .success(let response):
                guard let result = response?.results else { return }
                self.CharacterModelSubject.onNext(result)
            case .failure(let error):
                self.loadingBehavior.accept(false)
                print(error.localizedDescription)
            }
        }
    }
}
