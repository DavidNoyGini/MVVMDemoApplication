//
//  SecondVM.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 07/11/2021.
//

import Foundation
import UIKit

protocol SecondVMTableScreenProtocol: TableScreenVM
{
    var text: String? { get set }
}

class SecondVM: SecondVMTableScreenProtocol, Routing {
    
    var router: Router?
    var cellModels: [TableViewCellModel] = []
    weak var tableScreenVMDelegate: TableScreenVMDelegate?
    
    var text: String?
    
    init(text: String?, router: Router)
    {
        self.router = router
        setupMethod(text: text)
    }
    
    private func setupMethod(text: String?)
    {
        guard let text = text, let number = Int(text) else {return}
        self.text = text
        makeDataSource(number: number)
        if !cellModels.isEmpty
        {
            tableScreenVMDelegate?.reloadDataFromVM()
        }
    }
    
    
    func goButtonTapped(text: String?)
    {
        cellModels = []
        if let number = checkNumber(text: text)
        {
            makeDataSource(number: number)
            self.text = text
        }
        
        if !cellModels.isEmpty
        {
            tableScreenVMDelegate?.reloadDataFromVM()
        }
    }
    
    func userDidEnterText(text: String)
    {
        
    }
    
    func numberOfItemInSection(section: Int) -> Int
    {
        return cellModels.count
    }
    
    func getCellVM(indexPath: IndexPath) -> TableViewCellModel?
    {
        return cellModels[indexPath.row]
    }
    
    func userDidSelectRowAt(indexPath: IndexPath)
    {
        router?.moveTo(with: .toHome(startButton: text))
    }
    
    private func checkNumber(text: String?) -> Int?
    {
        guard let text = text else
        {
            tableScreenVMDelegate?.showErrorAlert(errorType: .empty)
            return nil
        }
        
        if let number = Int(text)
        {
            return number
        } else
        {
            tableScreenVMDelegate?.showErrorAlert(errorType: .notANumber)
        }
        return nil
    }
    
    private func makeDataSource(number: Int)
    {
        for index in 0..<number
        {
            cellModels.append(TableViewCellModel(text: String(index)))
        }
    }
    
}

