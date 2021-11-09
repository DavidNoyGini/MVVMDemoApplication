//
//  SecondDataSource.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import Foundation

class SecondDataSource: ViewModel {
    
    var type: ViewModelType = .secondVC
    var cellModels: [TableViewCellModel] = []
    
    func makeDataSource(number: Int)
    {
        for index in 0..<number
        {
            cellModels.append(TableViewCellModel(tappedString: String(index)))
        }
    }
    
    func getCellModel(i: Int) -> TableViewCellModel {
        return cellModels[i]
    }
}
