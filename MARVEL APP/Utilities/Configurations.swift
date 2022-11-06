//
//  Configurations.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 02/11/2022.
//

import Foundation

struct Configurations {
    static func getValue(for key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) else { return "" }
        return value as! String
    }
}
