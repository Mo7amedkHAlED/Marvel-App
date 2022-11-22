

//
//  favouriteViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 31/10/2022.
//
import RxSwift
import RxCocoa


class FavouriteListVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var favouriteTabelView: UITableView!
    
    let favoriteViewModel = FavouriteViewModel()
    let disposeBag = DisposeBag()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableView()
        subscribeToResponse()
        fetchCaracterListDB()
        favouriteTabelView.rx.setDelegate(self).disposed(by: disposeBag)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCaracterListDB()
        favouriteTabelView.reloadData()
    }
    
    // MARK: - create method to get data from realm
    private func fetchCaracterListDB() {
        
        favoriteViewModel.fetchCaracterListDB()
    }
    
    // MARK: - Configure Table View
    private func registerTableView() {
        favouriteTabelView.register(UINib(nibName: "SearchTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTableViewCell")
    }
    // MARK: - Binding TAbel View Cell with Model
    func subscribeToResponse() {
        self.favoriteViewModel.favoriteModelObservable
            .bind(to: self.favouriteTabelView
                .rx
                .items(cellIdentifier: "SearchTableViewCell",
                       cellType: SearchTableViewCell.self)) { row, data, cell in
                cell.configureCell(data)
                cell.row = row
                cell.delegate = self
                
                
            }.disposed(by: disposeBag)
    }
}
// MARK: - FavoriteButton protocol conformance
extension FavouriteListVC : FavoritesView {
    //MARK: - protocol function
    public func didTappedFavoriteButton(_ row: Int) {
        favoriteViewModel.deteteItemFromRealm(row: row)
        print("\(row) has detete")
    }
}

// MARK: - Make Extension Form HomeViewController To Customize Cell Height
extension FavouriteListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
