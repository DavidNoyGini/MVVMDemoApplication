//
//  Router.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 08/11/2021.
//

import UIKit

enum Event {
    case toHome(startButton: String? = "Start!", dataPassedButton: String? = "Data passed!")
    case toSecondVC(text: String?)
    case toThirdVC(text: String?)
    case toFourthVC(text: String?)
}

protocol Router {
    
    var navigationController: UINavigationController? { get set }
    
    func moveTo(with type: Event)
    func start()
}

protocol Routing {
    var router: Router? { get set }
}

