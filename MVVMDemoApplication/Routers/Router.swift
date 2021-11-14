//
//  Router.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 08/11/2021.
//

import UIKit

enum Event {
    case firstVC(startButtonTitle: String? = "Start!", dataPassedButtonTitle: String? = "Data passed!")
    case secondVC(text: String?)
    case thirdVC(text: String?)
    case fourthVC(text: String?)
}

protocol Router {
    var navigationController: UINavigationController? { get set }
    func navigate(to type: Event)
    func start()
}

protocol Routing {
    var router: Router? { get set }
}

