//
//  ViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 26/10/2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    //
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Vars
    //
    var ChaArry2 = [MarvelHome]()
    var currentCha = [MarvelHome]()
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCharaacter()
        searchBarSetUp()
        registerTableView()
        
    }
    
    // MARK: - INIT NEW ELEMENT IN ARRAY
    //
    func setUpCharaacter(){
        ChaArry2 = [
            .init(image:"Iro_Man", text: "Iro_Man", des: "Hello IN Marvel App "),
            .init(image:"Marvel1",text: "Marvel", des: "Hello IN Marvel App "),
            .init(image:"Spaider_Man1" , text: "Spaider_Man", des: "Hello IN Marvel App "),
            .init(image:"Iro_Man", text: "Iro_Man", des: "Hello IN Marvel App "),
            .init(image:"Marvel1",text: "Marvel", des: "Hello IN Marvel App "),
            .init(image:"Spaider_Man1" , text: "Spaider_Man", des: "Hello IN Marvel App "),
            .init(image:"Iro_Man", text: "Iro_Man", des: "Hello IN Marvel App "),
            .init(image:"Marvel1",text: "Marvel", des: "Hello IN Marvel App "),
            .init(image:"Spaider_Man1" , text: "Spaider_Man", des: "Hello IN Marvel App "),
            .init(image:"Iro_Man", text: "Iro_Man", des: "Hello IN Marvel App "),
            .init(image:"Marvel1",text: "Marvel", des: "Hello IN Marvel App "),
            .init(image:"Spaider_Man1" , text: "Spaider_Man", des: "Hello IN Marvel App "),
            .init(image:"Iro_Man", text: "Iro_Man", des: "Hello IN Marvel App "),
            .init(image:"Marvel1",text: "Marvel", des: "Hello IN Marvel App "),
            .init(image:"Spaider_Man1" , text: "Spaider_Man", des: "Hello IN Marvel App "),
            .init(image:"Iro_Man", text: "Iro_Man", des: "Hello IN Marvel App "),
            .init(image:"Marvel1",text: "Marvel", des: "Hello IN Marvel App "),
            .init(image:"Spaider_Man1" , text: "Spaider_Man", des: "Hello IN Marvel App "),
            .init(image:"Iro_Man", text: "Iro_Man", des: "Hello IN Marvel App "),
            .init(image:"Marvel1",text: "Marvel", des: "Hello IN Marvel App "),
            .init(image:"Spaider_Man1" , text: "Spaider_Man", des: "Hello IN Marvel App "),
            .init(image:"Iro_Man", text: "Iro_Man", des: "Hello IN Marvel App "),
            .init(image:"Marvel1",text: "Marvel", des: "Hello IN Marvel App "),
            .init(image:"Spaider_Man1" , text: "Spaider_Man", des: "Hello IN Marvel App ")
        ]
        currentCha = ChaArry2
        
    }
    
    // MARK: -  Search Bar Delegate
    //
    
    func searchBarSetUp(){
        searchBar.delegate = self
    }
    
    // MARK: - Configure TableView
    //
    func registerTableView(){
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        
    }
    
    // MARK: - IBAction
    //
    @IBAction func CancelButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
   
}

// MARK: - Create Extension Table View Delegate & Data Source methods
//
extension SearchViewController : TableView {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.ChaArry = currentCha[indexPath.row]
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCha.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.searchLabel.text = currentCha[indexPath.row].text
        cell.saerchImage.image = UIImage(named: currentCha[indexPath.row].image)
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

// MARK: - Create Extension  UISearch Bar Delegate
//
extension SearchViewController : UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currentCha = ChaArry2.filter({ $0.text.contains(searchText) })
        searchTableView.reloadData()
       }
    
}
