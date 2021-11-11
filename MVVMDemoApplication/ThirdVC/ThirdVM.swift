//
//  ThirdVM.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import UIKit

class ThirdVM: Routing {
    
    var router: Router?
    var text: String?
    private var thirdDataSource: [CollectionViewCellModel] = []
    
    init(router: Router?)
    {
        self.router = router
    }
    
    func makeDataSource(number: String?) -> [CollectionViewCellModel]
       {
           text = number
           guard let stringNumber = number,
                 let intNumber = Int(stringNumber) else {return []}
           
           for _ in 0..<intNumber
           {
               thirdDataSource.append(CollectionViewCellModel())
           }
           return thirdDataSource
       }
   
   func getCellModel(i: Int) -> CollectionViewCellModel {
       return thirdDataSource[i]
   }
    
    func userDidSelectItemAt(indexPath: IndexPath)
    {
        router?.moveTo(with: .toFourthVC(text: text))
    }
}
