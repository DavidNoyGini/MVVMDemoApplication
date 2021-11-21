//
//  FourthAPIManager.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 09/11/2021.
//

import Foundation
import Alamofire

struct FourthAPIManager {
    
    private static let baseUrl = "https://data.gov.il/api/3/action/datastore_search"
    private static let resource_id = "5c78e9fa-c2e2-4771-93ff-7f400a12f7ba"
    
    static func fetchCities(citiesString: String, completion: @escaping (([String]?, StateAndErrors) -> Void))
    {
        let queryItem = ["resource_id": resource_id, "q": citiesString]
        
        guard let url = URL(string: baseUrl)  else
        {
            completion(nil,.urlEror)
            return
        }
        
        AF.request(url,
                   method: .get,
                   parameters: queryItem,
                   encoding: URLEncoding.default,
                   headers: nil).responseJSON
        { (response) in
            print(response.value ?? "Got no response")
            
            
            
            guard let data = response.data else
            {
                completion(nil,.noData)
                return
            }
            
            guard response.error == nil else
            {
                completion(nil,.sessionError)
                return
            }
            
            do
            {
                let apiResult = try JSONDecoder().decode(APIResult.self, from: data)
                let fillteredResulte = citiesFilter(apiResult: apiResult, text: citiesString)
                completion(fillteredResulte,.success)
            } catch
            {
                completion(nil,.cantDecode)
            }
        }
    }
 
        
//        let queryItem = [URLQueryItem(name: "resource_id", value: resource_id), URLQueryItem(name: "q", value: citiesString)]
//        guard var urlComponents = URLComponents(string: baseUrl) else {return}
//        urlComponents.queryItems = queryItem
//
//
//        guard let url = urlComponents.url else
//        {
//            completion(nil,.urlEror)
//            return
//        }
//
//        URLSession.shared.dataTask(with: url)
//        { data, response, err in
//
//            guard let data = data else
//            {
//                completion(nil,.noData)
//                return
//            }
//
//            guard err == nil else
//            {
//                completion(nil,.sessionError)
//                return
//            }
//
//            do
//            {
//                let apiResult = try JSONDecoder().decode(APIResult.self, from: data)
//                let fillteredResulte = citiesFilter(apiResult: apiResult, text: citiesString)
//                completion(fillteredResulte,.success)
//            } catch
//            {
//                completion(nil,.cantDecode)
//            }
//        }.resume()
//    }
    
    private static func citiesFilter(apiResult: APIResult, text: String) -> [String]
    {
        let citiesArray = apiResult.result.records
        
        let citiesStringArray = citiesArray.map {$0.city}
        
        return citiesStringArray.filter {$0.contains(text)}
    }
    
}


