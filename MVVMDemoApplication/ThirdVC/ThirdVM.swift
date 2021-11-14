//
//  ThirdVM.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import UIKit

protocol ThirdVCActivityIndicator: AnyObject {
    func setActivityIndicatorVisibility(isVisible: Bool)
}

class ThirdVM: Routing {
    
    var router: Router?
    var text: String?
    var thirdCellViewModels: [CollectionViewCellModel] = []
    weak var thirdVCActivityIndicatorDelegate: ThirdVCActivityIndicator?
    
    init(router: Router?, number: String?, delegate: ThirdVCActivityIndicator)
    {
        self.router = router
        thirdVCActivityIndicatorDelegate = delegate
        loadCollectionViewCellModel(number: number)
    }
    
    private func loadCollectionViewCellModel(number: String?)
    {
        thirdCellViewModels = makeCellViewModels(number: number)
        { [weak self] in
            guard let self = self else {return}
            self.thirdVCActivityIndicatorDelegate?.setActivityIndicatorVisibility(isVisible: false)
        }
    }
    
    func makeCellViewModels(number: String?, comletion: @escaping (() -> Void)) -> [CollectionViewCellModel]
    {
        thirdVCActivityIndicatorDelegate?.setActivityIndicatorVisibility(isVisible: true)
        text = number
        guard let stringNumber = number,
              let intNumber = Int(stringNumber) else {return []}
        
        for _ in 0..<intNumber
        {
            thirdCellViewModels.append(CollectionViewCellModel())
        }
        comletion()
        return thirdCellViewModels
    }
    
    func getCellModel(indexPath: IndexPath) -> CollectionViewCellModel
    {
        return thirdCellViewModels[indexPath.row]
    }
    
    func userDidSelectItemAt(indexPath: IndexPath)
    {
        router?.navigate(to: .fourthVC(text: text))
    }
    
    func getNumberOfItemsInSection(numberOfItemsInSection section: Int) -> Int
    {
        return thirdCellViewModels.count
    }
}
