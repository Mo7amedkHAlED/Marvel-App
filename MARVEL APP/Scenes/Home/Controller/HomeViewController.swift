//
//  HomeViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 25/10/2022.
//

import UIKit

class HomeViewController: UIViewController {
    /// IBOutlet
    ///
    @IBOutlet weak var TableView: UITableView!
    
    /// Declear var
    ///
    var ChaArry : [MarvelHome] = []
    private var images : [String] = []
    private var currentPage = 1
    override var prefersStatusBarHidden: Bool{return true}
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TableView.prefetchDataSource = self
        setUpCharaacter()
        registerCollectionView()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Marvel"))
    }
    
    func setUpCharaacter(){
        ChaArry = [
            .init(image:"Iro_Man", text: "Iro_Man"),
            .init(image:"Marvel1",text: "Marvel"),
            .init(image:"Spaider_Man1" , text: "Spaider_Man"),
            .init(image:"Iro_Man", text: "Iro_Man"),
            .init(image:"Marvel1",text: "Marvel"),
            .init(image:"Spaider_Man1" , text: "Spaider_Man"),
            .init(image:"Iro_Man", text: "Iro_Man"),
            .init(image:"Marvel1",text: "Marvel"),
            .init(image:"Spaider_Man1" , text: "Spaider_Man"),
            .init(image:"Iro_Man", text: "Iro_Man"),
            .init(image:"Marvel1",text: "Marvel"),
            .init(image:"Spaider_Man1" , text: "Spaider_Man"),
            .init(image:"Iro_Man", text: "Iro_Man"),
            .init(image:"Marvel1",text: "Marvel"),
            .init(image:"Spaider_Man1" , text: "Spaider_Man"),
            .init(image:"Iro_Man", text: "Iro_Man"),
            .init(image:"Marvel1",text: "Marvel"),
            .init(image:"Spaider_Man1" , text: "Spaider_Man"),
            .init(image:"Iro_Man", text: "Iro_Man"),
            .init(image:"Marvel1",text: "Marvel"),
            .init(image:"Spaider_Man1" , text: "Spaider_Man"),
            .init(image:"Iro_Man", text: "Iro_Man"),
            .init(image:"Marvel1",text: "Marvel"),
            .init(image:"Spaider_Man1" , text: "Spaider_Man")
        ]
    }
    func registerCollectionView(){
        TableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        TableView.delegate = self
        TableView.dataSource = self
        
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController")
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)

    }
    
    
}
// MARK: - Table View Delegate and Data Source methods
//
extension HomeViewController : TableView { 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChaArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.characterName.text = ChaArry[indexPath.row].text
        cell.Tableimage.image = UIImage(named: ChaArry[indexPath.row].image) 
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}
// MARK: - Create Extension UITableViewDataSourcePrefetching
//
extension HomeViewController : UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let dataInRow = ChaArry[indexPath.row]
        }
    }
    
}
