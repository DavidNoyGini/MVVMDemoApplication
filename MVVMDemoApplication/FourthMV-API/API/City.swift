//
//  City.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 09/11/2021.
//

import Foundation

struct Ciry {
    let city: String
    
    enum CodingKeys: String, CodingKey {
        case city = "שם_ישוב"
    }
}

extension Ciry: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decode(String.self, forKey: .city)
    }
}

//
//struct Coordinate {
//    var latitude: Double
//    var longitude: Double
//    var elevation: Double
//
//    enum CodingKeys: String, CodingKey {
//        case latitude
//        case longitude
//        case additionalInfo
//    }
//
//    enum AdditionalInfoKeys: String, CodingKey {
//        case elevation
//    }
//}
//
//extension Coordinate: Decodable {
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        latitude = try values.decode(Double.self, forKey: .latitude)
//        longitude = try values.decode(Double.self, forKey: .longitude)
//
//        let additionalInfo = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
//        elevation = try additionalInfo.decode(Double.self, forKey: .elevation)
//    }
//}
