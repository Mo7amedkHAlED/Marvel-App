//
//  HomeViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 25/10/2022.
//

import UIKit
import Alamofire
import Kingfisher
import ProgressHUD

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var TableView: UITableView!
    
    // MARK: - Vars
    var charactersArray: [Character] = []
    private var images : [String] = []
    
    // MARK: - Pagination Vars
    var charactersPerPages = 10
    var limit = 10
    let api: CharactersList = CharactersServiceAPI()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchApiCharacterData()
        registerCollectionView()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Marvel"))
    }
    func fetchApiCharacterData() {
        api.getCharachters { (result) in
            switch result {
            case .success(let response):
                guard let result = response?.results else { return }
                self.charactersArray = result
                self.TableView.reloadData()
                ProgressHUD.dismiss()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
// MARK: - Configure CollectionView
    func registerCollectionView() {
        TableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
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
        cell.configureCell(tableData: charactersArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == TableView {
            if limit <= 100 {
                if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height){
                    fetchApiCharacterData()
                }
            }
        }
    }
}
