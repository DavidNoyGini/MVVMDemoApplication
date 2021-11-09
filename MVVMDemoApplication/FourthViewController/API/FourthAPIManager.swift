//
//  FourthAPIManager.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 09/11/2021.
//

import Foundation

struct FourthAPIManager {
    
    private static let baseUrl = "https://data.gov.il/api/3/action/datastore_search"
    private static let resource_id = "5c78e9fa-c2e2-4771-93ff-7f400a12f7ba"
    
    static func fetchCities(citiesString: String, completion: @escaping ((APIResult?, APIState) -> Void))
    {
        if citiesString.isInt
        {
            completion(nil,.inValidInput)
        }
        
        let queryItem = [URLQueryItem(name: "resource_id", value: resource_id), URLQueryItem(name: "q", value: citiesString)]
        guard var urlComponents = URLComponents(string: baseUrl) else {return}
        urlComponents.queryItems = queryItem
        
        
        guard let url = urlComponents.url else
        {
            completion(nil,.urlEror)
            return
        }
        
        URLSession.shared.dataTask(with: url)
        { data, response, err in
            
            guard let data = data else
            {
                print(APIState.noData.rawValue)
                completion(nil,.noData)
                return
            }
            
            guard err == nil else
            {
                print(APIState.sessionError.rawValue)
                print(err!)
                completion(nil,.sessionError)
                return
            }
            
            do
            {
                let apiResult = try JSONDecoder().decode(APIResult.self, from: data)
                completion(apiResult,.success)
            } catch
            {
                print(APIState.cantDecode.rawValue)
                print(error)
                completion(nil,.cantDecode)
            }
            
            
        }.resume()
    }
    
}

enum APIState: String {
    case inValidInput = "In Valid Input"
    case urlEror = "URL Error"
    case noData = "No Data"
    case sessionError = "Session Error"
    case noConnection = "No Connection"
    case cantDecode = "Can't Decode"
    case success = "Success"
}


