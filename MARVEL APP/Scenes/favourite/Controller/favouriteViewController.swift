//
//  favouriteViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 31/10/2022.
//

import UIKit

class favouriteViewController: UIViewController, FavoriteButton {

    @IBOutlet weak var favouriteTabelView: UITableView!
    let images: [UIImage] = [
            UIImage(named: "Iro_Man")!, UIImage(named: "Marvel1")!,
            UIImage(named: "Spaider_Man1")!, UIImage(named: "Iro_Man")!,
            UIImage(named: "Marvel1")!, UIImage(named: "Spaider_Man1")!
        ]
        let names: [String] = [
            " Iro_Man", "Spaider_Man", "Iro_Man",
            " Iro_Man", "Spaider_Man", "Iro_Man",
            " Iro_Man", "Spaider_Man", "Iro_Man"
        ]
    var isFav : [Bool] = [true, true, false, true, false, false]
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
    }
    
    func registerTableView(){
        favouriteTabelView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        
    }
    //MARK: - protocol function
    func didTappedFavoriteButton(_ row: Int) {
        let isFavorite = isFav[row]
        isFav[row] = !isFavorite
        favouriteTabelView.reloadData()
        
    }
   
}
extension favouriteViewController : TableView{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.saerchImage.image = images[indexPath.row]
        cell.searchLabel.text = names[indexPath.row]
        cell.row = indexPath.row
        cell.delegate = self
        let image = isFav[indexPath.row] == true ? UIImage(named: "favorite2") : UIImage(named: "unfavorite")
        cell.favoriteButton.setImage(image, for: .normal)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
