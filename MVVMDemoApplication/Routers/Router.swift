//
//  Router.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 08/11/2021.
//

import UIKit

enum Event {
    case toSecondVC
    case toThirdVC
}

protocol Router {
    var navigationController: UINavigationController? { get set }
    
    func eventOccurred(with type: Event)
    func start()
}

protocol Routing {
    var router: Router? { get set }
}
