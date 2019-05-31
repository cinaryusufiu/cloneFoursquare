//
//  PlaceViewController.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 30.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation
import GoogleMaps

protocol PlacesViewModelDelegate : NSObjectProtocol {
    func openPlaceDetailView()
    func errorGetDetailVenue()
}
class PlacesViewModel {
    
    weak var delegate : PlacesViewModelDelegate?
    
    var selectedVenue : Venue?
    
    private var venues : [Venue]
    
    init(venues : [Venue]) {
        self.venues = venues
    }
    func getVenus() -> [Venue] {
        return self.venues
    }
    func getNavigationTitle()-> String{
        return  AppConstant.NavigationBarTitle.navPlacesController
    }
    
    func onClickedCell(index : Int){
        
        if index < 0 || index >= self.venues.count {
            return
        }
        let venueId = venues[index].id
        getDetailVenue(venueId: venueId)
    }
    fileprivate func getDetailVenue(venueId : String) {
        guard let delegate = self.delegate else { return  }
        ApiService.shared.getDetailVenue(venueId: venueId) {  [weak delegate, weak self](venue, success) in
            if success {
                guard let venueModel = venue else {
                    delegate?.errorGetDetailVenue();
                    return }
                    self?.selectedVenue = venueModel
                    delegate?.openPlaceDetailView()
            }else {
                delegate?.errorGetDetailVenue()
            }
        }
    }
    //MARK: PlaceDetailView Helper
    
    func numberOfCollectionViewPlaceDetail() -> Int? {
        return  selectedVenue?.tips?.groups?.count
    }
    
    func textForCellPlaceDetail(index :Int) -> String? {
        
        if index >= selectedVenue?.tips?.groups?[index].count ?? 0   {
            return nil
        }
        let items = selectedVenue?.tips?.groups?[index].items
        var stringArray = [String]()
        for item in items ?? [ItemGroup]() {
            stringArray.append(item.text ?? "")
        }
        return stringArray.joined(separator: " ")
    }
    
    func locationCoordinate() -> CLLocationCoordinate2D? {
        return CLLocationCoordinate2D(latitude: Double(selectedVenue?.location?.lat ?? 0), longitude: Double(selectedVenue?.location?.lng ?? 0))
    }
    
    func imageUrlStringPlaceDetail() -> String? {
        guard  let prefix = selectedVenue?.bestPhoto?.prefix , let suffix = selectedVenue?.bestPhoto?.suffix else { return nil}
        
        return prefix + "500x200" + suffix
    }
}
