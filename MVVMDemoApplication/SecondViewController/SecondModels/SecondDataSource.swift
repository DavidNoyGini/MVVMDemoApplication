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
    
    func makeDataSource(tappedString: String, completion: @escaping () -> Void)
    {
        if let number = Int(tappedString)
        {
            for index in 0..<number
            {
                cellModels.append(TableViewCellModel(tappedString: String(index)))
            }
        }
        completion()
    }
    
    func getCellModel(i: Int) -> TableViewCellModel {
        return cellModels[i]
    }
}
