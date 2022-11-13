//
//  BaseResponse.swift
//  MARVEL APP
//
//  Created by Mohamed Khaled on 08/11/2022.
//

import Foundation


class BaseResponse<T: Codable>: Codable {
    var data: BasicDataResponse<T>?
    var code: Int?
}
