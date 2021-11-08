//
//  PicsumManager.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import Foundation
import EzHTTP
import EzImageLoader

struct PicsumManager {
    
    static func getImage(url: String) -> UIImage?{
        print(url)
        return ImageLoader.getASync(url)
    }
    
}