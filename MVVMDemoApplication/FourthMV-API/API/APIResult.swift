//
//  APIResult.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 09/11/2021.
//

import Foundation
import Alamofire

struct APIResult: Decodable, Encodable {
    let result: Cities
}
