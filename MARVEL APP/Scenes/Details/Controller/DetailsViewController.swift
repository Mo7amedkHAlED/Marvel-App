//
//  DetailsViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 26/10/2022.
//

import UIKit
import RealmSwift
import ProgressHUD

class DetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var comiceLabel: UILabel!
    @IBOutlet weak var comiceCollectionView: UICollectionView!
    @IBOutlet weak var stoiesLabel: UILabel!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var seriesLabel: UILabel!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var detailsImage: UIImageView!
    
    // MARK: - Vars
    var characterData  : Character?
    var combisData: [ResultData] = []
    var seriesData: [ResultData] = []
    var storesData: [ResultData] = []
    var eventsData: [ResultData] = []
    var dataArray : [ResultData] = []
    let realm = try! Realm()
    var dataCharacter: Results<CaractersModel>!
    let api: CharactersList = CharactersServiceAPI()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionView()
        initializationView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initializationCollectionView()
        fetchCaracterListDB()
        setInitimage()
    }
    
    // MARK: -  create method to get if character is favorite
    func setInitimage(){
        if dataCharacter.contains(where: {$0.caractersId == self.characterData?.id }) {
            UpdateFavoriteButtonImage(imageName: "favorite2")
        } else {
            UpdateFavoriteButtonImage(imageName: "unfavorite")
        }
    }
    
    // MARK: - Read from Realm
    private func fetchCaracterListDB() {
        dataCharacter = realm.objects(CaractersModel.self)
    }
    
    // MARK: - Change Favorite Button Image
    func ChangeFavoriteButtonImage(isFavorire: Bool) {
        if isFavorire == true {
            UpdateFavoriteButtonImage(imageName: "favorite2")
        } else {
            UpdateFavoriteButtonImage(imageName: "unfavorite")
        }
    }
    
    // MARK: - Update Favorite Button Image
    func UpdateFavoriteButtonImage(imageName : String) {
        let image = UIImage(named: imageName)
        favoriteButton.setImage(image, for: .normal)
    }
    
    func fetchCharacter(collectionName: String, completion: @escaping ([ResultData]) -> Void ) {
        guard let characterId = characterData?.id else{ return }
        api.getComics(id: characterId, name: collectionName) { (result) in
            switch result {
            case .success(let model):
                ProgressHUD.dismiss()
                guard let result = model?.results else { return }
                self.dataArray = result
                completion(self.dataArray)
                self.comiceCollectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    // MARK: -  Initialization View
    func initializationView() {
        backButton.layer.cornerRadius = 20
        backButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        characterName.text = characterData?.name
        let characterimage = "\(characterData?.thumbnail.path ?? " ").jpg"
        detailsImage.kf.setImage(with: URL(string: "\(characterimage)"))
        guard let descriptionText = characterData?.description else { return }
        desLabel.text = descriptionText
    }
    // MARK: - InitializationCollectionView
    func initializationCollectionView() {
        
        fetchCharacter(collectionName: "comics") { comics in
            self.combisData = comics
            self.comiceCollectionView.reloadData()
        }
        fetchCharacter(collectionName: "comics") { stores in
            self.storesData = stores
            self.storiesCollectionView.reloadData()
        }
        fetchCharacter(collectionName: "series") { series in
            self.seriesData = series
            self.seriesCollectionView.reloadData()
        }
        fetchCharacter(collectionName: "events") { events in
            self.eventsData = events
            self.eventCollectionView.reloadData()
        }
    }
    // MARK: - Set Image For Favorite Button
    @IBAction func favoriteButton(_ sender: UIButton) {
        if let object = dataCharacter.filter({ $0.caractersId == self.characterData?.id }).first {
            UpdateFavoriteButtonImage(imageName: "unfavorite")
            do {
                try realm.write {
                    realm.delete(object)
                }
            }
            catch {
                print("Error trying to delete object from realm database. \(error)")
            }
        } else {
            let characterISFav = CaractersModel()
            characterISFav.caractersName = characterData?.name ?? " "
            characterISFav.caractersId = characterData?.id ?? 0
            characterISFav.caractersImagePath = characterData?.thumbnail.path ?? " "
            characterISFav.caractersIsFavorite = characterData?.inFavorites ?? false
            print("name of character: \(characterISFav.caractersName)")
            do{
                try realm.write{
                    realm.add(characterISFav)
                }
            } catch {
                print("Error trying to delete object from realm database. \(error)")
            }
            favoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)
        }
    }
    // MARK: - Configure CollectionView
    func registerCollectionView() {
        comiceCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        
        storiesCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        
        seriesCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        
        eventCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
    }
    // MARK: - IBAction
    @IBAction func BackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
// MARK: -Create Extension CollectionView DataSource & Delegate Method
extension DetailsViewController : CollectionView {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == comiceCollectionView {
            isHidden(array: combisData, collection: comiceCollectionView, labelname: comiceLabel)
            return combisData.count
        } else if collectionView == seriesCollectionView {
            isHidden(array: seriesData, collection: seriesCollectionView, labelname: seriesLabel)
            return seriesData.count
        } else if collectionView == storiesCollectionView {
            isHidden(array: seriesData, collection: storiesCollectionView, labelname: stoiesLabel)
            return storesData.count
        } else {
            isHidden(array: eventsData, collection: eventCollectionView, labelname: eventLabel)
            return eventsData.count
        }
        func isHidden(array: [ResultData], collection : UICollectionView, labelname : UILabel ) {
            if array.count == 0 {
                collection.isHidden = true
                labelname.isHidden = true
            } else {
                collection.isHidden = false
                labelname.isHidden = false
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as! DetailsCollectionViewCell
        var result = [ResultData]()
        if collectionView == comiceCollectionView {
            result = combisData
        }
        else if collectionView == storiesCollectionView {
            result = storesData
        }
        else if collectionView == seriesCollectionView {
            result = seriesData
        }
        else {
            result = eventsData
        }
        cell.configureCell(collectionData: result[indexPath.row])
        return cell
    }
}
