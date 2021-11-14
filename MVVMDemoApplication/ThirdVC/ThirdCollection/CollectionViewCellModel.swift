//
//  CollectionViewCellModel.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import UIKit

class CollectionViewCellModel {
    var image: UIImage?
    
    init()
    {
        getImage()
    }
    
    private func getImage()
    {
        let i = Int.random(in: 1...100_000)
        let url = "\(StringsConstans.picsumBaseUrl)\(i)"
        
        if let fetchedImage = PicsumService.getImage(url: url)
        {
            self.image = fetchedImage
        }
    }
}

