//
//  CGFlaotExtension.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}
