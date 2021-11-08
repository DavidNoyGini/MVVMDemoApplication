//
//  SecondVCTableViewCell.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 04/11/2021.
//

import UIKit

class SecondVCTableViewCell: UITableViewCell {

    @IBOutlet weak var textLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func configure(with model: TableViewCellModel)
    {
        self.textLabelOutlet.text = model.number
    }
}
