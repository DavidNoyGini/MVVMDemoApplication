//
//  MainRouter.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 08/11/2021.
//

import UIKit

class MainRouter: Router {
    var navigationController: UINavigationController?
    
    func eventOccurred(with type: Event)
    {

        switch type
        {
        case .toHome:
            print("to Home")
        case .toSecondVC:
            moveToSecondVC()
        case .toThirdVC:
            moveToThirdVC()
        case .toFourthVC:
            moveToFourthVC()
        }
        
        
    }
    
    func start()
    {
        let vc = HomeViewController()
        vc.router = self
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    func remove(type: ViewModelType)
    {
        switch type
        {
        case .FourthVC:
            navigationController?.popToRootViewController(animated: true)
        default:
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    private func moveToSecondVC()
    {
        guard let homeVC = navigationController?.viewControllers[0] as? HomeViewController else { return }
        let vc = SecondViewController(dataSource: SecondDataSource())
        vc.router = self
        vc.searchedString = homeVC.searchedString
        vc.searchDelegate = homeVC
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func moveToThirdVC()
    {
        guard let homeVC = navigationController?.viewControllers[0] as? HomeViewController else { return }
        let thirdDataSource = ThirdDataSource().makeDataSource(number: homeVC.searchedString)
        let vc = ThirdViewController(thirdDataSource: thirdDataSource)
        vc.router = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func moveToFourthVC()
    {
        guard let homeVC = navigationController?.viewControllers[0] as? HomeViewController else { return }
        let vc = SecondViewController(dataSource: FourthDataSource())
        vc.router = self
        vc.searchDelegate = homeVC
        navigationController?.pushViewController(vc, animated: true)
    }
}


