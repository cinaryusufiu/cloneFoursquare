//
//  ApiService.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 29.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation
import Alamofire
class ApiService: NSObject {
    
    static let shared = ApiService()
    
    func getSearchResult(query : String, key :String ,value : String,completionHandler:@escaping([Venue]?, Bool)->()){
        let parameters = [
            AppConstant.ApiKey.client_id: AppConstant.ApiKeyValue.client_id,
            AppConstant.ApiKey.client_secret: AppConstant.ApiKeyValue.client_secret,
            AppConstant.ApiKey.version: AppConstant.ApiKeyValue.version,
            AppConstant.ApiKey.query: query,
            key : value
        ]
        Alamofire.request(AppConstant.URl.search ,parameters: parameters, headers: nil)
            .responseJSON { response in
                guard response.result.isSuccess, let responseData = response.data else {
                    print("Error \(String(describing: response.result.error))")
                    return completionHandler(nil, false)
                }
                do {
                    let apiBaseModel = try JSONDecoder().decode(ObjectModel<ResponseArray>.self, from: responseData)
                    completionHandler(apiBaseModel.dataApi?.venues , true)
                } catch let error {
                    print(error)
                    completionHandler(nil , false)
                }
        }
    }
    
    func getDetailVenue(venueId :String,completionHandler:@escaping(Venue?, Bool)->()){
        
        let parameters = [
            AppConstant.ApiKey.client_id: AppConstant.ApiKeyValue.client_id,
            AppConstant.ApiKey.client_secret: AppConstant.ApiKeyValue.client_secret,
            AppConstant.ApiKey.version: AppConstant.ApiKeyValue.version]
        
        Alamofire.request(AppConstant.URl.baseUrl + venueId ,parameters: parameters, headers: nil)
            .responseJSON { response in
                print(response)
                guard response.result.isSuccess, let responseData = response.data else {
                    print("Error \(String(describing: response.result.error))")
                    return completionHandler(nil, false)
                }
                do {
                    let apiBaseModel = try JSONDecoder().decode(ObjectModel<ResponseModel>.self, from: responseData)
                    completionHandler(apiBaseModel.dataApi?.venue , true)
                } catch let error {
                    print(error)
                    completionHandler(nil , false)
                }
                
        }
    }
}
