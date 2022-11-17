//
//  String+md5.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 08/11/2022.
//

import UIKit
import CryptoKit

let publicKey = Configurations.getValue(for: "Public_Key")
let privateKey = Configurations.getValue(for: "Private_Key")


//MARK: - Get MD5 Method
func MD5(string: String) -> String {
    let digest = Insecure.MD5.hash(data: string.data(using: .utf8) ?? Data())
    
    return digest.map {
        String(format: "%02hhx", $0)
    }.joined()
    
}
