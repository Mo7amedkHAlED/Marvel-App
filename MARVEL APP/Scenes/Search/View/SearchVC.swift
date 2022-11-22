//
//  ViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 26/10/2022.
//

import RxSwift
import RxCocoa

class SearchVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cancelButton: UIButton!
    
    // MARK: - Vars
    let searchViewModel = SearchViewModel()
    let disposeBag = DisposeBag()
    var text: String?
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToCancelButton()
        registerTableView()
        subscribeToResponse()
        subscribeToBranchSelection()
        subscribeToLoading()
        searchTableView.rx.setDelegate(self).disposed(by: disposeBag)
        
    }
    // MARK: - Configure TableView
    func registerTableView() {
        searchTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
        
    }
    // MARK: - Method to show & hidden loader
    func subscribeToLoading() {
        searchViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
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
            .zip(searchTableView.rx.itemSelected, searchTableView.rx.modelSelected(CharactersListModel.self))
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
    // MARK: - Binding Tabel View Cell with Model
    func subscribeToResponse() {
        self.searchViewModel.searchModelObservable
            .bind(to: self.searchTableView
                .rx
                .items(cellIdentifier: "SearchTableViewCell",
                       cellType: SearchTableViewCell.self)) { row, data, cell in
                cell.configureSearchCell(data)
            }.disposed(by: disposeBag)
    }
    
    // MARK: - MAke dismiss Action in cancel Button
    func subscribeToCancelButton() {
        cancelButton.rx.tap.subscribe {[weak self] (_) in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }.disposed(by: disposeBag)
    }
    // MARK: - Get Character List From Api
    func getSearchCharacters(search : String) {
        searchViewModel.fetchApiCharacterData(searchText: search )
    }
}
// MARK: - Make Extension Form HomeViewController To Customize Cell Height
extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}

// MARK: - Make Extension Form HomeViewController To Customize Scroll
extension SearchVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        text = searchText
        getSearchCharacters(search: searchText)
        searchTableView.reloadData()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == searchTableView {
            if limit <= 100 {
                if (scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height) {
                    getSearchCharacters(search: text ?? " ")
                }
            }
        }
    }
}
