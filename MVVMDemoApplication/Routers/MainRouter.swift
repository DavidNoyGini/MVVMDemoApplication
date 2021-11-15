//
//  MainRouter.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 08/11/2021.
//

import UIKit

class MainRouter: Router {
    var navigationController: UINavigationController?
    
    func navigate(to type: Event)
    {
        switch type
        {
        case .firstVC(let start, let passed):
            moveToHomeVC(startButton: start, dataPassed: passed)
        case .secondVC(let text):
            moveToSecondVC(text: text)
        case .thirdVC(let text):
            moveToThirdVC(text: text)
        case .fourthVC(let text):
            moveToFourthVC(text: text)
        }
    }
    
    func start()
    {
        let firstVM = FirstVM(router: self)
        let vc = FirstVC(viewModel: firstVM)
        firstVM.firstVMActivityIndicatorDelegate = vc
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    private func moveToHomeVC(startButton: String?,dataPassed: String?)
    {
        guard let firsVC = navigationController?.viewControllers.first(where: { $0 is FirstVC }) as? FirstVC else { return }
        firsVC.setStartButtonTitle(text: startButton)
    //    firsVC.startButton.setTitle(startButton, for: .normal)
        firsVC.setPassedDataTitle(dataPassed: dataPassed)
  //      firsVC.text = startButton
        navigationController?.popToViewController(firsVC, animated: true)
    }
    
    private func moveToSecondVC(text: String?)
    {
        let secondVM = SecondVM(text: text, router: self)
        let vc = SecondVC(viewModel: secondVM)
        secondVM.tableScreenVMDelegate = vc
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func moveToThirdVC(text: String?)
    {
        guard let firsVC = navigationController?.viewControllers.first(where: { $0 is FirstVC }) as? FirstVC else { return }
        let viewModel = ThirdVM(router: self, number: text, delegate: firsVC.viewModel)
        let vc = ThirdVC(viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
     
    private func moveToFourthVC(text: String?)
    {
        let fourthMV = FourthVM(router: self, text: text)
        let vc = SecondVC(viewModel: fourthMV)
        fourthMV.tableScreenVMDelegate = vc
        navigationController?.pushViewController(vc, animated: true)
    }
}


