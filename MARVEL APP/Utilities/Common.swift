//
//  Common.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 25/10/2022.
//

import Foundation
import UIKit


let api: UsersAPIProtocol = CharactersServiceAPI()

typealias TableView = UITableViewDelegate & UITableViewDataSource

typealias CollectionView = UICollectionViewDataSource & UICollectionViewDelegate
