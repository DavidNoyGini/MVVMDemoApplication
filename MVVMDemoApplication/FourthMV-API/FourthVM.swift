//
//  FourthVM.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 09/11/2021.
//

import Foundation

class FourthVM: Routing {

    var router: Router?
    private var text: String?
    private var cellModels: [TableViewCellModel] = []
    weak var tableScreenVMDelegate: TableScreenVMDelegate?
    
    init(router: Router, text: String?)
    {
        self.router = router
        self.text = text
    }
    
    func goButtonTapped(text: String?)
    {
        cellModels = []
        guard let text = text else
        {
            tableScreenVMDelegate?.showErrorAlert(errorType: .empty)
            return
        }
        
        if text.isEmpty
        {
            tableScreenVMDelegate?.showErrorAlert(errorType: .empty)
            return
        }
        
        if !text.isLetters
        {
            tableScreenVMDelegate?.showErrorAlert(errorType: .noteALetter)
            return
        }
        
        makeCellViewModels(text: text)
        { [weak self] in
            self?.reloadData()
        }

    }
    
    private func reloadData()
    {
        if cellModels.isEmpty
        {
            tableScreenVMDelegate?.showErrorAlert(errorType: .inValidInput)
        } else
        {
            tableScreenVMDelegate?.reloadDataFromVM()
        }
    }
}

// MARK: - TableScreenVM Protocol
extension FourthVM: TableScreenVM {
    
    func userDidEnterText(text: String)
    {
        // Nothing here yet
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
         let city = cellModels[indexPath.row].text
         router?.navigate(to: .firstVC(startButtonTitle: text, dataPassedButtonTitle: city))
    }
    
    func makeCellViewModels(text: String, completion: @escaping () -> Void)
    {
        FourthAPIManager.fetchCities(citiesString: text)
        { [weak self] citiesResult, statAndErrors in
            
            switch statAndErrors
            {
            case .success:
                guard citiesResult != nil,
                      let cities = citiesResult else {return}
                
                let count = cities.count
                
                for index in 0..<count
                {
                    self?.cellModels.append(TableViewCellModel(text: cities[index]))
                }
                completion()
            default:
                self?.tableScreenVMDelegate?.showErrorAlert(errorType: statAndErrors)
                return
            }
        }
    }

}




