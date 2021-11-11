//
//  PicsumService.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import Foundation
import EzHTTP
import EzImageLoader

struct PicsumService {
    
    static func getImage(url: String) -> UIImage?{
        print(url)
        return ImageLoader.getASync(url)
    }
    
//    static func getImage(url: String, completion: @escaping ((UIImage?) -> Void))
//    {
//        guard let request = HTTP.createRequest(.GET, url, params: [:], headers: [:]) else
//        {
//            completion(nil)
//            return
//        }
//
//        ImageLoader.request(request) {
//            completion($0.image)
//        }
//    }
    
}
