//
//  SecondVCTableViewCell.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 04/11/2021.
//

import UIKit
import Reusable

class SecondVCTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet weak var textLabelOutlet: UILabel!
    
    func configure(with model: TableViewCellModel)
    {
        self.textLabelOutlet.text = model.tappedString
    }
}
