//
//  HomeViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 25/10/2022.
//

import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    // MARK: - VARS
    let homeViewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    // MARK: - Outlets
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var TableView: UITableView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCharacters()
        makeNavigationTitle()
        subscribeToResponse()
        registerCollectionView()
        subscribeToBranchSelection()
        subscribeToLoading()
        subscribeToSearch()
        TableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    // MARK: - MAKE NAVIGATION Title TO HOME VIEW
    func makeNavigationTitle() {
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Marvel"))
    }
    // MARK: - Configure Collection View
    func registerCollectionView() {
        TableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
    }
    // MARK: - Binding TAbel View Cell with Model
    func subscribeToResponse() {
        self.homeViewModel.CharacterModelObservable
            .bind(to: self.TableView
                .rx
                .items(cellIdentifier: "TableViewCell",
                       cellType: TableViewCell.self)) { row, data, cell in
                cell.configureCell(tableData: data)
            }.disposed(by: disposeBag)
    }
    // MARK: -  To Go TO Search Controller View When click Search Button
    func subscribeToSearch() {
        searchButton.rx.tap.subscribe { (_) in
            let storyboard = UIStoryboard(name: "Search", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController")
            vc.modalPresentationStyle = .currentContext
            self.definesPresentationContext = true
            self.present(vc, animated: true)
        }.disposed(by: disposeBag)
    }
    // MARK: - Method to show & hidden loader
    func subscribeToLoading() {
        homeViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                self.showIndicator(withTitle: "", and: "")
            } else {
                self.hideIndicator()
            }
        }).disposed(by: disposeBag)
    }
    // MARK: - Create Method To Know Selection Cell
    func subscribeToBranchSelection() {
        Observable
            .zip(TableView.rx.itemSelected, TableView.rx.modelSelected(CharactersListModel.self))
            .bind { [weak self] selectedIndex, data in
                guard let self = self else { return }
                let storyboard = UIStoryboard(name: "Details", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
                vc.characterData = data
                vc.modalPresentationStyle = .overFullScreen
                self.present(vc, animated: true)
        }
        .disposed(by: disposeBag)
    }
    // MARK: - Get Character List From Api
    func getCharacters() {
        homeViewModel.fetchApiCharacterData()
    }
}
    // MARK: - Make Extension Form HomeViewController To Customize Cell Height
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
    // MARK: - Make Extension Form HomeViewController To Customize Scroll
extension HomeViewController : UISearchBarDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == TableView {
            if limit <= 100 {
                if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height) {
                    getCharacters()
                }
            }
        }
    }
}
