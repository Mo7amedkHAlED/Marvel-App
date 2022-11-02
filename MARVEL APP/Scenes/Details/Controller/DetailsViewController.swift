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
    //
    @IBOutlet weak var ComiceCollectionView: UICollectionView!
    @IBOutlet weak var StoriesCollectionView: UICollectionView!
    @IBOutlet weak var SeriesCollectionView: UICollectionView!
    @IBOutlet weak var FavoriteButton: UIButton!
    @IBOutlet weak var EventCollectionView: UICollectionView!
    @IBOutlet weak var CharacterName: UILabel!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var DesLabel: UILabel!
    @IBOutlet weak var DetailsImage: UIImageView!
    
    // MARK: - Vars
    //
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
    //
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
    
    func setInitimage(){
        if dataCharacter.contains(where: {$0.caractersId == self.characterData?.id }) {
            FavoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)
        } else {
            FavoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
        }
    }
    // MARK: - Read from Realm
    private func read() {
        
        print("Read from Realm")
        dataCharacter = realm.objects(CaractersModel.self)
        
    }
    // MARK: - Change Favorite Button Image
    func ChangeFavoriteButtonImage(isFavorire: Bool){
        if isFavorire == true {
            let image = UIImage(named: "favorite2")
            FavoriteButton.setImage(image, for: .normal)
        } else {
            let image = UIImage(named: "unfavorite")
            FavoriteButton.setImage(image, for: .normal)
        }
    }
    // MARK: -  Initialization View
    func initializationView(){
        BackButton.layer.cornerRadius = 20
        BackButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        CharacterName.text = characterData?.name
        var characterimage = characterData?.thumbnail.path ?? " "
        characterimage += ".jpg"
        DetailsImage.kf.setImage(with: URL(string: "\(characterimage)"))
        guard let descriptionText = characterData?.description else {return}
        DesLabel.text = descriptionText
    }
    // MARK: - InitializationCollectionView
    func initializationCollectionView(){
        
        fetchCharacter(collectionName: "comics") { comics in
            self.combisData = comics
            self.ComiceCollectionView.reloadData()
        }
        fetchCharacter(collectionName: "comics") { stores in
            self.storesData = stores
            self.StoriesCollectionView.reloadData()
        }
        fetchCharacter(collectionName: "series") { series in
            self.seriesData = series
            self.SeriesCollectionView.reloadData()
        }
        fetchCharacter(collectionName: "events") { events in
            self.eventsData = events
            self.EventCollectionView.reloadData()
        }
    }
    
    // MARK: - Fetching Data From Api
    func fetchCharacter(collectionName: String, completion: @escaping ([ResultData]) -> Void ){
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
            FavoriteButton.setImage(UIImage(named: "unfavorite"), for: .normal)
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
                
            }
            FavoriteButton.setImage(UIImage(named: "favorite2"), for: .normal)
        }
        
    }
// MARK: - Configure CollectionView
func registerCollectionView(){
    ComiceCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
    
    StoriesCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
    
    SeriesCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
    
    EventCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
}
// MARK: - IBAction
@IBAction func BackButton(_ sender: UIButton) {
    dismiss(animated: true)
}

}
// MARK: -Create Extension CollectionView DataSource & Delegate Method
extension DetailsViewController : CollectionView{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == ComiceCollectionView {
            return combisData.count
        } else if collectionView == SeriesCollectionView {
            return seriesData.count
        } else if collectionView == StoriesCollectionView {
            return storesData.count
        } else {
            return eventsData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as! DetailsCollectionViewCell
        var result = [ResultData]()
        if collectionView == ComiceCollectionView {
            result = combisData
        }
        else if collectionView == StoriesCollectionView {
            result = storesData
        }
        else if collectionView == SeriesCollectionView {
            result = seriesData
        }
        else {
            result = eventsData
        }
        cell.CharcterLabel.text = result[indexPath.row].title
        var characterimage = result[indexPath.row].thumbnail.path
        characterimage += ".jpg"
        cell.CharcterImage.kf.setImage(with: URL(string: "\(characterimage)"))
        return cell
    }
}
