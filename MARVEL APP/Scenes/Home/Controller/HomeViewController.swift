//
//  HomeViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 25/10/2022.
//

import UIKit
import CryptoKit
import Alamofire
import Kingfisher
import ProgressHUD

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var TableView: UITableView!
    
    // MARK: - Vars
    var charactersArray: [Character] = []
    private var images : [String] = []
    var publicKey = "01973c54d87ab24faec3795d522b42b1"
    var privateKey = "b79e717f216cf6b9f154732ed97c1b69bd8586f8"
    
    // MARK: - Pagination Vars
    var charactersPerPages = 10
    var limit = 10
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchApiCharacterData(limit: limit)
        registerCollectionView()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Marvel"))
    }
    
    // MARK: - Fetching Data From Api
    func fetchApiCharacterData(limit: Int) {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(ts)\(privateKey)\(publicKey)")
        guard let url =  URL(string: "https://gateway.marvel.com:443/v1/public/characters?limit=\(limit)&ts=\(ts)&hash=\(hash)&apikey=\(publicKey)") else { return }
        ProgressHUD.show()
        AF.request(url, method: .get,encoding: JSONEncoding.default).responseDecodable(of: APIResult.self) { [self] respone in
            switch respone.result{
            case.success(let character):
                self.charactersArray = character.data.results
                self.limit += 10
                self.TableView.reloadData()
                ProgressHUD.dismiss()
            case.failure(let error):
                print(error.localizedDescription)
                ProgressHUD.showError()
                
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
    
    // MARK: - Configure CollectionView
    func registerCollectionView() {
        TableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        TableView.delegate = self
        TableView.dataSource = self
        
    }
    
    // MARK: - IBAction
    @IBAction func searchButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController")
        vc.modalPresentationStyle = .currentContext
        self.definesPresentationContext = true
        present(vc, animated: true)
    }
}
// MARK: - Create Extension Table View Delegate & Data Source methods
extension HomeViewController : TableView {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersArray.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.characterData = charactersArray[indexPath.row]
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let characterName = charactersArray[indexPath.row].name
        cell.characterName.text = characterName
        var characterimage = charactersArray[indexPath.row].thumbnail.path
        characterimage += ".jpg"
        cell.characterHomeImage.kf.setImage(with: URL(string: "\(characterimage)"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == TableView {
            if limit <= 100 {
                if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height){
                    fetchApiCharacterData(limit: limit)
                }
            }
        }
    }
    
}
