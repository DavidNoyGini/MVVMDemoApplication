//
//  FourthDataSource.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 09/11/2021.
//

import Foundation

class FourthDataSource: ViewModel {
    
    var type: ViewModelType = .FourthVC
    var cellModels: [TableViewCellModel] = []
    
    func makeDataSource(number: Int)
    {
        for index in 0..<number
        {
            cellModels.append(TableViewCellModel(tappedString: String(index * 2)))
        }
    }
    
    func getCellModel(i: Int) -> TableViewCellModel {
        return cellModels[i]
    }
}
