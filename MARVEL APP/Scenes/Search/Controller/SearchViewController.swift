//
//  ViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 26/10/2022.
//

import UIKit
import CryptoKit
import Alamofire
import Kingfisher
import ProgressHUD
class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Vars
    var characterArrayData = [Character]()
    var searchArrayData = [Character]()
    var charactersPerPages = 10
    var limit = 10
    var publicKey = "01973c54d87ab24faec3795d522b42b1"
    var privateKey = "b79e717f216cf6b9f154732ed97c1b69bd8586f8"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchApiCharacterData(limit: limit, searchText: " ")
        
        searchBarSetUp()
        registerTableView()
        
    }
    
    // MARK: - Fetching Data From Api
    func fetchApiCharacterData(searchText: String){
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(ts)\(privateKey)\(publicKey)")
        guard let searchText = searchBar.text else { return}
        guard let url =  URL(string: "https://gateway.marvel.com:443/v1/public/characters?nameStartsWith=\(searchText)&limit=\(limit)&ts=\(ts)&hash=\(hash)&apikey=\(publicKey)") else { return}
        AF.request(url, method: .get,encoding: JSONEncoding.default).responseDecodable(of: APIResult.self) { [self] respone in
            switch respone.result{
            case.success(let data):
                self.searchArrayData = data.data.results
                self.limit += 10
                self.searchTableView.reloadData()
            case.failure(let error):
                print(error.localizedDescription)

            }
        }
    }
    
    //MARK: - Get MD5 Method
    func MD5(string: String) -> String {
        let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())

        return digest.map {
            String(format: "%02hhx", $0)
        }.joined()
        
    }
    
    // MARK: -  Search Bar Delegate
    func searchBarSetUp(){
        searchBar.delegate = self
    }
    
    // MARK: - Configure TableView
    func registerTableView(){
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        
    }
    
    // MARK: - IBAction
    @IBAction func CancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: - Create Extension Table View Delegate & Data Source methods
extension SearchViewController : TableView {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.chaArry = searchArrayData[indexPath.row]
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.searchLabel.text = searchArrayData[indexPath.row].name
        var characterimage = searchArrayData[indexPath.row].thumbnail.path
        characterimage += ".jpg"
        cell.saerchImage.kf.setImage(with: URL(string: "\(characterimage)"))
        cell.favoriteButton.isHidden = true
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

// MARK: - Create Extension  UISearch Bar Delegate
extension SearchViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchApiCharacterData(searchText: searchText)
        print(searchBar)
        searchTableView.reloadData()
       }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == searchTableView {
            if limit <= 100{
                if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height){
                    fetchApiCharacterData(searchText: " ")
                }
            }
        }
    }

}
