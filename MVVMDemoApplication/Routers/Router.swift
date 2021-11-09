//
//  Router.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 08/11/2021.
//

import UIKit

enum Event {
    case toHome
    case toSecondVC
    case toThirdVC
    case toFourthVC
}

protocol Router {
    var navigationController: UINavigationController? { get set }
    
    func eventOccurred(with type: Event)
    func start()
    func remove(type: ViewModelType)
}

protocol Routing {
    var router: Router? { get set }
}
