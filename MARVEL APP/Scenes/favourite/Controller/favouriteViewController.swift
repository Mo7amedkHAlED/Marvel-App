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
// TODO: - Refactor the name of the class and the file to match swift naming convension
// TODO: - Refactor this view controller to have the FavoriteButton protocol conformance in a separate extesniosn
// for more readable and clean code style
class favouriteViewController: UIViewController, FavoriteButton {
    
    // MARK: - Outlets
    @IBOutlet weak var favouriteTabelView: UITableView!
    
    //TOOD: -Change the mark title to be more convenient name
    // MARK: - Vars
    let realm = try! Realm()
    // TODO: - Rename this var to more descriptive name like `favoriteCharactersList`...
    // TODO: - Refactor this stored property to be observer property and reload the table view data when
    // Receving any new value
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
    
    //TODO: - Rename this method to more readable name
    //TODO: - Refactor this method to add the ability to catch the errors thrown from the realm operation
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
        } catch {
            print("Error trying to delete object from realm database. \(error)")
        }
    }
}

// MARK: - Create Extension Table View Delegate & Data Source methods
extension favouriteViewController : TableView {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCharacter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        //TODO: - Move this configuration to a separate mehtod like:
        // func configureCell(cell: UITableViewCell, for indexPath: Int) {...}
        //TODO: - Try to get the image extesnion from the api and replace this static extension
        let imagePath = "\(dataCharacter[indexPath.row].caractersImagePath).jpg"
        cell.saerchImage.kf.setImage(with: URL(string: "\(imagePath)"))
        cell.searchLabel.text = dataCharacter[indexPath.row].caractersName
        cell.row = indexPath.row
        //TODO: - Move this logic to a separatre func since the below block is used to update the the image of the button
        // like func UpdateFavoriteButtonImage() {...}
        cell.delegate = self
        let image = UIImage(named: "favorite2")
        cell.favoriteButton.setImage(image, for: .normal)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
