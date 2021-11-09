//
//  ThirdVCCollectionViewCell.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import UIKit
import Reusable

class ThirdVCCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var imageViewOutlet: UIImageView!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func configure(with model: CollectionViewCellModel)
    {
        imageViewOutlet.image = model.image
    }
}
