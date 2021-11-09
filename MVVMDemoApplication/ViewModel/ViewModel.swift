//
//  ViewModel.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 09/11/2021.
//

import Foundation

protocol ViewModel {
    var type: ViewModelType { get set }
    var cellModels: [TableViewCellModel] { get set }
    func makeDataSource(number: Int)
    func getCellModel(i: Int) -> TableViewCellModel
}

enum ViewModelType{
    case secondVC
    case FourthVC
    case futureVC
}
