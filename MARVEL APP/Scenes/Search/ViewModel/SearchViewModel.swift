//
//  SearchViewModel.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 17/11/2022.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class SearchViewModel {
    
    var loadingBehavior = BehaviorRelay<Bool>(value: false)
    
    private var searchModelSubject = PublishSubject<[CharactersListModel]>()
    
    var searchModelObservable: Observable<[CharactersListModel]> {
        return searchModelSubject
    }
    
    // MARK: - Fetching Data From Api
    func fetchApiCharacterData(searchText: String) {
        if searchText.isEmpty {
            loadingBehavior.accept(false)
        } else {
            loadingBehavior.accept(true)
            api.getSearchResult(nameStartsWith: searchText) { [weak self] (result) in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.loadingBehavior.accept(false)
                    guard let result = response?.results else { return }
                    self.searchModelSubject.onNext(result)
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
