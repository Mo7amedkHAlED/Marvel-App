//
//  DetailsViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 26/10/2022.
//

import UIKit
import CryptoKit
import Alamofire
import RealmSwift

class DetailsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var comiceCollectionView: UICollectionView!
    @IBOutlet weak var storiesCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var eventCollectionView: UICollectionView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var detailsImage: UIImageView!
    
    // MARK: - Vars
    var publicKey = "01973c54d87ab24faec3795d522b42b1"
    var privateKey = "b79e717f216cf6b9f154732ed97c1b69bd8586f8"
    var characterData  : Character?
    var combisData: [ResultData] = []
    var seriesData: [ResultData] = []
    var storesData: [ResultData] = []
    var eventsData: [ResultData] = []
    var dataArray : [ResultData] = []
    let realm = try! Realm()
    var dataCharacter: Results<CaractersModel>!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionView()
        initializationCollectionView()
        initializationView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        read()
        setInitimage()
        
    }
    // MARK: -  create method to get if character is favorite
    func setInitimage(){
        
        if dataCharacter.contains(where: {$0.caractersId == self.characterData?.id }) {
            favoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
        }
        
    }
    // MARK: - Read from Realm
    private func read() {
        
        print("Read from Realm")
        dataCharacter = realm.objects(CaractersModel.self)
        
    }
    // MARK: - Change Favorite Button Image
    func ChangeFavoriteButtonImage(isFavorire: Bool) {
        
        if isFavorire == true {
            let image = UIImage(named: "favorite2")
            favoriteButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(named: "unfavorite")
            favoriteButton.setImage(image, for: .normal)
        }
        
    }
    // MARK: -  Initialization View
    func initializationView() {
        backButton.layer.cornerRadius = 20
        backButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        characterName.text = characterData?.name
        var characterimage = characterData?.thumbnail.path ?? " "
        characterimage += ".jpg"
        detailsImage.kf.setImage(with: URL(string: "\(characterimage)"))
        guard let descriptionText = characterData?.description else {return}
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
    
    // MARK: - Fetching Data From Api
    func fetchCharacter(collectionName: String, completion: @escaping ([ResultData]) -> Void ) {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(string: "\(ts)\(privateKey)\(publicKey)")
        guard let characterId = characterData?.id else{return}
        guard let url =  URL(string: "https://gateway.marvel.com:443/v1/public/characters/\(characterId)/\(collectionName)?ts=\(ts)&hash=\(hash)&apikey=\(publicKey)") else {return}
        AF.request(url, method: .get,encoding: JSONEncoding.default).responseDecodable(of: APICollectionResult.self) { [self] respone in
            switch respone.result{
            case.success(let model):
                self.dataArray = model.data.results
                completion(dataArray)
            case.failure(let error):
                print(error.localizedDescription)
                
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
    // MARK: - Set Image For Favorite Button
    @IBAction func favoriteButton(_ sender: UIButton) {
        if let object = dataCharacter.filter({ $0.caractersId == self.characterData?.id }).first {
            favoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
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
func registerCollectionView(){
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
extension DetailsViewController : CollectionView{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == comiceCollectionView {
            return combisData.count
        } else if collectionView == seriesCollectionView {
            return seriesData.count
        } else if collectionView == storiesCollectionView {
            return storesData.count
        } else {
            return eventsData.count
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
        cell.charcterLabel.text = result[indexPath.row].title
        var characterimage = result[indexPath.row].thumbnail.path
        characterimage += ".jpg"
        cell.charcterImage.kf.setImage(with: URL(string: "\(characterimage)"))
        return cell
    }
}
