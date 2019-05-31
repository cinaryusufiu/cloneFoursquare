//
//  LocationManager.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 31.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//
import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationManager()
    public lazy var clLocationManager : CLLocationManager = CLLocationManager()
    
    fileprivate var latitude: CLLocationDegrees = 0.0
    fileprivate var longitude: CLLocationDegrees = 0.0
    
    override init() {
        super.init()
        
         clLocationManager.requestAlwaysAuthorization()
        self.clLocationManager.showsBackgroundLocationIndicator = false
        self.clLocationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.clLocationManager.distanceFilter = 500
        self.clLocationManager.allowsBackgroundLocationUpdates = false
        self.clLocationManager.pausesLocationUpdatesAutomatically = true
        DispatchQueue.main.async {
            self.clLocationManager.delegate = self
            self.clLocationManager.startMonitoringSignificantLocationChanges()
            self.clLocationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let clLocation = manager.location?.coordinate else { return }
        
        latitude = clLocation.latitude
        longitude = clLocation.longitude
    }
    
    func getLocationMe() -> CLLocationCoordinate2D {
        locationManager(clLocationManager, didUpdateLocations: [CLLocation(latitude: latitude, longitude: longitude)])
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        locationManager(clLocationManager, didUpdateLocations: [CLLocation(latitude: latitude, longitude: longitude)])
        print(status)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Fail exceptionn....")
    }
}

