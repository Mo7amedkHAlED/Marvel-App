//
//  DataModel.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 01/11/2022.
//

import RealmSwift

class CaractersModel: Object {
    
    @objc dynamic var caractersName: String = " "
    @objc dynamic var caractersId: Int = 0
    @objc dynamic var caractersImagePath: String = " "
    @objc dynamic var caractersIsFavorite: Bool = false
    
    convenience init(name: String, id: Int, imagePath: String, isFavorite: Bool){
        self.init()
        self.caractersName = name
        self.caractersId = id
        self.caractersImagePath = imagePath
        self.caractersIsFavorite = isFavorite
    }
}
