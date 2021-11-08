//
//  UIExtension.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}
