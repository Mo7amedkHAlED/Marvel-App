//
//  favouriteViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 31/10/2022.
//

import UIKit
import RealmSwift
import ProgressHUD

class FavouriteListVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var favouriteTabelView: UITableView!
    
    // MARK: - Declare Realm
    let realm = try! Realm()
    var favoriteCharactersList: Results<CaractersModel>!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCaracterListDB()
        favouriteTabelView.reloadData()
    }
    
    // MARK: - create method to get data from realm
    private func fetchCaracterListDB() {
        
        favoriteCharactersList = realm.objects(CaractersModel.self)
    }
    
    // MARK: - Configure Table View
    private func registerTableView() {
        favouriteTabelView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
    }
}
// MARK: - FavoriteButton protocol conformance
//
extension FavouriteListVC : FavoritesView {
    //MARK: - protocol function
    public func didTappedFavoriteButton(_ row: Int) {
        do {
            try realm.write {
                realm.delete(favoriteCharactersList[row])
                self.favouriteTabelView.reloadData()
            }
        } catch {
            print("Error trying to delete object from realm database. \(error)")
        }
    }
}

// MARK: - Create Extension Table View Delegate & Data Source methods
extension FavouriteListVC : TableView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteCharactersList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.row = indexPath.row
        cell.delegate = self
        cell.configureCell(favoriteCharactersList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
