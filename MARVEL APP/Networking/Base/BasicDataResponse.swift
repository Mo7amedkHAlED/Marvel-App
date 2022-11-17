//
//  BasicDataResponse.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 09/11/2022.
//

import Foundation

class BasicDataResponse <T: Codable>:  Codable {
    let results: T?
    let count: Int?
}
