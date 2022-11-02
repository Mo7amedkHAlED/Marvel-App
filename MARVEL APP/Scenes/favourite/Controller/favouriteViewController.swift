//
//  favouriteViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 31/10/2022.
//

import UIKit
import RealmSwift
import Kingfisher
import ProgressHUD

class favouriteViewController: UIViewController, FavoriteButton {
    
    // MARK: - Outlets
    @IBOutlet weak var favouriteTabelView: UITableView!
    
    // MARK: - Vars
    let realm = try! Realm()
    var dataCharacter: Results<CaractersModel>!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        read()
        favouriteTabelView.reloadData()
    }
    
    // MARK: - create method to get data from realm
    private func read() {
        dataCharacter = realm.objects(CaractersModel.self)
    }
    // MARK: - Configure Table View
    private func registerTableView(){
        favouriteTabelView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        
    }
    //MARK: - protocol function
    public func didTappedFavoriteButton(_ row: Int) {
        do {
            try realm.write {
                realm.delete(dataCharacter[row])
                self.favouriteTabelView.reloadData()
            }
        }
        catch {
            print("Error trying to delete object from realm database. \(error)")
        }
    }
}

// MARK: - Create Extension Table View Delegate & Data Source methods
extension favouriteViewController : TableView{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCharacter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        let imagePath = "\(dataCharacter[indexPath.row].caractersImagePath).jpg"
        cell.saerchImage.kf.setImage(with: URL(string: "\(imagePath)"))
        cell.searchLabel.text = dataCharacter[indexPath.row].caractersName
        cell.row = indexPath.row
        cell.delegate = self
        let image = UIImage(named: "favorite2")
        cell.favoriteButton.setImage(image, for: .normal)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
