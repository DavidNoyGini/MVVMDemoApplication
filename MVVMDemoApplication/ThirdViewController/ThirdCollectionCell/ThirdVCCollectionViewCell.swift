//
//  ThirdVCCollectionViewCell.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import UIKit

class ThirdVCCollectionViewCell: UICollectionViewCell {

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
