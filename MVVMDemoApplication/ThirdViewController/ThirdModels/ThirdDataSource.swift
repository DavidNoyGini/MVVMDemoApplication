//
//  ThirdDataSource.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import UIKit

class ThirdDataSource {
    
    private var thirdDataSource: [CollectionViewCellModel] = []
    
    func makeDataSource(number: String?) -> [CollectionViewCellModel]
       {
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
}
