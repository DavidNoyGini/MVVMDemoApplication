//
//  TableViewProtocols.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 09/11/2021.
//

import Foundation

/// Input
protocol TableScreenVM {
    
    func goButtonTapped(text: String?)
    func userDidEnterText(text: String)
    func numberOfItemInSection(section: Int) -> Int
    func getCellVM(indexPath: IndexPath) -> TableViewCellModel?
    func userDidSelectRowAt(indexPath: IndexPath)
    
}

/// Output
protocol TableScreenVMDelegate: AnyObject {
    func reloadDataFromVM()
    func showErrorAlert(errorType: TableScreenVMError)
}

enum TableScreenVMError: String {
    case invalidInput = "Invalid Input"
    case notANumber = "Numbers only"
    case empty = "Please enter a number"
    case noteALetter = "Please use letters only"
}
