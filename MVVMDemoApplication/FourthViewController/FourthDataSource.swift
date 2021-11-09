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
    
    func makeDataSource(tappedString: String, completion: @escaping () -> Void)
    {
        FourthAPIManager.fetchCities(citiesString: tappedString)
        { [weak self] apiResult, apiState in
            
            switch apiState
            {
            case .success:
                let citiesResult = apiResult?.result.records
                guard citiesResult != nil,
                      let cities = citiesResult else {return}
                
                let count = cities.count
                
                for index in 0..<count
                {
                    self?.cellModels.append(TableViewCellModel(tappedString: cities[index].city))
                }
                completion()
            default:
                print(apiState.rawValue)
                return
            }
            
        }
    }
    
    func getCellModel(i: Int) -> TableViewCellModel {
        return cellModels[i]
    }
    

    
}
