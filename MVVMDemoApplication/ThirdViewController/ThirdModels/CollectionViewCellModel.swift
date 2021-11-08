//
//  CollectionViewCellModel.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import UIKit

struct CollectionViewCellModel {
    var image: UIImage?
    
    init(){
        let i = Int.random(in: 1...100_000)
        if let fetchedImage = PicsumManager.getImage(url: "\(StringsConstans.picsumBaseUrl)\(i)") {
            self.image = fetchedImage
        }
    }
}

