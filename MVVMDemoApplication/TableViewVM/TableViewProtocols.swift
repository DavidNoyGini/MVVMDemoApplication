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
    func showErrorAlert(errorType: StateAndErrors)
}

enum StateAndErrors: String {
    case inValidInput = "Invalid Input"
    case notANumber = "Numbers only"
    case empty = "Please enter a number"
    case noteALetter = "Please use letters only"
    case urlEror = "URL Error"
    case noData = "No Data"
    case sessionError = "Session Error"
    case noConnection = "No Connection"
    case cantDecode = "Can't Decode"
    case success = "Success"
}



//enum StateAndErrors: String {
//    case invalidInput = "Invalid Input"
//    case notANumber = "Numbers only"
//    case empty = "Please enter a number"
//    case noteALetter = "Please use letters only"
//}
