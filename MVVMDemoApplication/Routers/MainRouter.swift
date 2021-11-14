//
//  MainRouter.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 08/11/2021.
//

import UIKit

class MainRouter: Router {
    var navigationController: UINavigationController?
    
    func moveTo(with type: Event)
    {
        switch type
        {
        case .toHome(let start, let passed):
            moveToHomeVC(startButton: start, dataPassed: passed)
        case .toSecondVC(let text):
            moveToSecondVC(text: text)
        case .toThirdVC(let text):
            moveToThirdVC(text: text)
        case .toFourthVC(let text):
            moveToFourthVC(text: text)
        }
    }
    
    func start()
    {
        let vc = FirstVC(viewModel: FirstVM(router: self))
        navigationController?.setViewControllers([vc], animated: false)
    }
    
    private func moveToHomeVC(startButton: String?,dataPassed: String?)
    {
        guard let firsVC = navigationController?.viewControllers.first(where: { $0 is FirstVC }) as? FirstVC else { return }
        firsVC.startButton.setTitle(startButton, for: .normal)
        firsVC.setPassedDataTitle(dataPassed: dataPassed)
        firsVC.text = startButton
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
        let viewModel = ThirdVM(router: self)
        let thirdDataSource = viewModel.makeDataSource(number: text)
        let vc = ThirdVC(thirdDataSource: thirdDataSource, viewModel: viewModel)
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


