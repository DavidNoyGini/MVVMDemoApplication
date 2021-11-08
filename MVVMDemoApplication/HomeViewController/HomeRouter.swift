//
//  HomeRouter.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 08/11/2021.
//

import UIKit

class HomeRouter: Router {
    var navigationController: UINavigationController?
    
    func eventOccurred(with type: Event) {
        guard let homeVC = navigationController?.viewControllers[0] as? HomeViewController else { return }
        
        switch type {
        case .toSecondVC:
            moveToPage2(choosenNumber: homeVC.choosenNumber)
        case .toThirdVC:
            print("to third")
        }
        
        
    }
    
    func start() {
        var vc: UIViewController & Routing = HomeViewController()
        vc.router = self
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    func moveToPage2(choosenNumber: String?)
    {
//        let router = Page2Router()
//        router.navigationController = navigationController
        let vc = SecondViewController()
        vc.router = self
        vc.choosenNumber = choosenNumber
        navigationController?.setViewControllers([vc], animated: false)
    }
    
}
