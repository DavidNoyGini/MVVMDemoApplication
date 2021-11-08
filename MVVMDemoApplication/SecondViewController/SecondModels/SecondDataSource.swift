//
//  SecondDataSource.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import Foundation


class SecondDataSource {
    
     var cellNumbers: [TableViewCellModel] = []
    
     func makeDataSource(number: Int)
        {
            for index in 0...number
            {
                cellNumbers.append(TableViewCellModel(number: String(index)))
            }
        }
    
    func getCellModel(i: Int) -> TableViewCellModel {
        return cellNumbers[i]
    }
}
