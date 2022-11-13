//
//  ViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 26/10/2022.
//

import UIKit
import ProgressHUD

class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Vars
    var characterArrayData = [Character]()
    var searchArrayData = [Character]()
    let api: CharactersList = CharactersServiceAPI()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBarSetUp()
        registerTableView()
        
    }
    // MARK: - Fetching Data From Api
    func fetchApiCharacterData(searchText: String) -> String {
        if searchText.isEmpty{
            return " "
        }else{
            guard let searchText = searchBar.text else { return " " }
            api.getSearchResult(nameStartsWith: searchText) {  (result) in
                switch result {
                case.success(let data):
                    ProgressHUD.dismiss()
                    self.searchArrayData = data?.results ?? []
                    self.searchTableView.reloadData()
                case.failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        return " "
    }
    // MARK: -  Search Bar Delegate
    func searchBarSetUp() {
        searchBar.delegate = self
    }
    
    // MARK: - Configure TableView
    func registerTableView() {
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        
    }
    
    // MARK: - IBAction
    @IBAction func CancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
}

// MARK: - Create Extension Table View Delegate & Data Source methods
extension SearchViewController: TableView {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.characterData = searchArrayData[indexPath.row]
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.configureSearchCell(searchArrayData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

// MARK: - Create Extension  UISearch Bar Delegate
extension SearchViewController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        fetchApiCharacterData(searchText: searchText)
        searchTableView.reloadData()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == searchTableView {
            if limit <= 100 {
                if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height){
                    fetchApiCharacterData(searchText: " ")
                }
            }
        }
    }
}
