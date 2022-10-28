//
//  HomeViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 25/10/2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var TableView: UITableView!
    
    // MARK: - Vars
    var charactersArray: [MarvelHome] = []
    private var images : [String] = []
    override var prefersStatusBarHidden: Bool{return true}
    
    // MARK: - Pagination Vars
        var charactersPerPages = 10
        var limit = 10
        var paginationCharacters: [MarvelHome] = []
        
    override func viewDidLoad() {
    // MARK: - Life Cycle
        super.viewDidLoad()
        
//        TableView.prefetchDataSource = self
        setUpCharaacter()
        registerCollectionView()
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Marvel"))
        
        
    }
    
    // MARK: - INIT NEW ELEMENT IN ARRAY
    func setUpCharaacter(){
        charactersArray = [
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
        limit = charactersArray.count
        for i in 0 ..< 10{
            paginationCharacters.append(charactersArray[i])
        }
    }
    
    // MARK: - Get Pagination Characters
    func setPaginationCharacters(charactersPerPages: Int){
        if charactersPerPages >= limit{
            return
        }
        else if charactersPerPages >= limit - 10{
            for i in charactersPerPages ..< limit{
                paginationCharacters.append(charactersArray[i])
            }
            self.charactersPerPages += 10
        }
        else{
            for i in charactersPerPages ..< charactersPerPages + 10{
                paginationCharacters.append(charactersArray[i])
            }
            self.charactersPerPages += 10
        }
        DispatchQueue.main.async {
            self.TableView.reloadData()
        }
    }
    
    // MARK: - Configure CollectionView
    func registerCollectionView(){
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
        return paginationCharacters.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        let storyboard = UIStoryboard(name: "Details", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        vc.ChaArry = charactersArray[indexPath.row]
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.characterName.text = paginationCharacters[indexPath.row].text
        cell.Tableimage.image = UIImage(named: paginationCharacters[indexPath.row].image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == TableView {
            if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height){
             setPaginationCharacters(charactersPerPages: charactersPerPages)
            }
        }
    }
    
}
//// MARK: - Create Extension UITableViewDataSourcePrefetching
//extension HomeViewController : UITableViewDataSourcePrefetching{
//
//    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            let dataInRow = charactersArray[indexPath.row]
//        }
//    }
//
//}
