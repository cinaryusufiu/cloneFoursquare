//
//  SearchViewModel.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 29.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation

protocol SearchViewModelDelegate : NSObjectProtocol {
    func startHud()
    func stopHud()
    func openPlacesViewPage(venues : [Venue])
    func errorDataApi()
    func emptyData()
}
class SearchViewModel: BaseViewModel {
    
    weak var delegate : SearchViewModelDelegate?
    
    override func setupInit() {
        super.setupInit()
        
    }
    func getNavigationTitle()-> String{
        return  AppConstant.NavigationBarTitle.navSearchController
    }
    func handleSendButton(query : String , location : String?){
        var key :String = "ll"
        let locationMe = LocationManager.shared.getLocationMe()
        var keyValue : String = "\(locationMe.latitude),\(locationMe.longitude)"
        // "\(41.43),\(27.34)"
        if location?.count ?? 0 > 0{
            key = "near"
            keyValue = location ?? ""
        }
        getApiSearchWithParam(query: query, key: key, keyValue: keyValue)
    }
    
    fileprivate func getApiSearchWithParam(query :String, key : String, keyValue : String){
        guard let delegate = self.delegate else { return  }
        delegate.startHud()
        ApiService.shared.getSearchResult(query: query, key: key, value: keyValue) {
            (venues, success) in
            guard success else { return delegate.errorDataApi()}
            if let venueArray = venues{
                delegate.stopHud()
                delegate.openPlacesViewPage(venues: venueArray)
                return
            }else{
                delegate.emptyData()
            }
        }
    }
}
