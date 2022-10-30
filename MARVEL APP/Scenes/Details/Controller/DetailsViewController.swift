//
//  DetailsViewController.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 26/10/2022.
//

import UIKit

class DetailsViewController: UIViewController {

    // MARK: - Outlets
    //
    @IBOutlet weak var ComiceCollectionView: UICollectionView!
    @IBOutlet weak var StoriesCollectionView: UICollectionView!
    @IBOutlet weak var SeriesCollectionView: UICollectionView!
    @IBOutlet weak var EventCollectionView: UICollectionView!
    @IBOutlet weak var CharacterName: UILabel!
    @IBOutlet weak var BackButton: UIButton!
    @IBOutlet weak var DesLabel: UILabel!
    @IBOutlet weak var DetailsImage: UIImageView!
    
    // MARK: - Vars
    //
    var ChaArry  : Character?
    let images: [UIImage] = [
        UIImage(named: "Iro_Man")!, UIImage(named: "Marvel1")!,
        UIImage(named: "Spaider_Man1")!, UIImage(named: "Iro_Man")!,
        UIImage(named: "Marvel1")!, UIImage(named: "Spaider_Man1")!
    ]
    let names: [String] = [
        " Iro_Man", "Spaider_Man", "Iro_Man",
        " Iro_Man", "Spaider_Man", "Iro_Man",
        " Iro_Man", "Spaider_Man", "Iro_Man"
    ]
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackButton.layer.cornerRadius = 20
        BackButton.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        registerCollectionView()
        CharacterName.text = ChaArry?.name
        var characterimage = ChaArry?.thumbnail.path ?? " "
        characterimage += ".jpg"
        DetailsImage.kf.setImage(with: URL(string: "\(characterimage)"))
        guard let descriptionText = ChaArry?.description else {return}
        DesLabel.text = descriptionText
        print(ChaArry?.description)
        
    }
    // MARK: - Configure CollectionView
    //
    func registerCollectionView(){
        ComiceCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        ComiceCollectionView.delegate = self
        ComiceCollectionView.dataSource = self
        ComiceCollectionView.reloadData()

        StoriesCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        StoriesCollectionView.delegate = self
        StoriesCollectionView.dataSource = self
        StoriesCollectionView.reloadData()

        SeriesCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        SeriesCollectionView.delegate = self
        SeriesCollectionView.dataSource = self
        SeriesCollectionView.reloadData()

        EventCollectionView.register(UINib(nibName: "DetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DetailsCollectionViewCell")
        EventCollectionView.delegate = self
        EventCollectionView.dataSource = self
        EventCollectionView.reloadData()

    }
    // MARK: - IBAction
    //
    @IBAction func BackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
// MARK: -Create Extension CollectionView DataSource & Delegate Method
//
extension DetailsViewController : CollectionView{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsCollectionViewCell", for: indexPath) as! DetailsCollectionViewCell
        cell.CharcterLabel.text = names[indexPath.row]
        cell.CharcterImage.image = images[indexPath.row]
        return cell
    }
    
    
}
