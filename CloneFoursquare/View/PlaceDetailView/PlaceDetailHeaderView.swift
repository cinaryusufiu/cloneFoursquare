//
//  PlaceDetailHeaderView.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 31.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import SDWebImage
class PlaceDetailHeaderView: UICollectionViewCell{
    
    static let cellId = "PlaceDetailHeaderViewId"
    
    var imageUrl : String? {
        didSet{
            guard let imageString = self.imageUrl ,  let url  = URL(string: imageString) else { return }
            self.venueImageView.sd_setImage(with:url)
        }
    }
    var locCoordinate :CLLocationCoordinate2D?{
        didSet{
            guard let locCoordinate = self.locCoordinate else { return  }
            setNewMarkerLocation(latitude: locCoordinate.latitude, longitude: locCoordinate.longitude)
        }
    }
    lazy var googleMapView : GMSMapView = {
        let camera = GMSCameraPosition.camera(withLatitude: locCoordinate?.latitude ??  0 , longitude: locCoordinate?.longitude ?? 0, zoom: 16)
        let mv = GMSMapView.map(withFrame: .zero, camera:camera)
        mv.settings.indoorPicker = false
        return mv
    }()
    var marker : GMSMarker = {
        let mrkr = GMSMarker()
        mrkr.iconView?.alpha = 1
        mrkr.tracksViewChanges = true
        return mrkr
    }()
    let venueImageView : UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .white
        view.image = UIImage(named: "background")
        view.contentMode = UIView.ContentMode.scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    let titleDescriptionLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.backgroundColor = .gray
        return label
    }()
    let descriptionTextLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.backgroundColor = .white
    }
    fileprivate func setupView(){
        setupAddView()
        setupAddConstraint()
        setupMarkerView()
    }
    fileprivate func setupAddView(){
        self.addSubview(googleMapView)
        self.addSubview(venueImageView)
        self.addSubview(titleDescriptionLabel)
        self.addSubview(descriptionTextLabel)
    }
    fileprivate func setupAddConstraint(){
        
        googleMapView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, paddingTop: 0, paddingleft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200, centerX: nil, centerY: nil)
        venueImageView.anchor(top: self.googleMapView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, paddingTop: 0, paddingleft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 200, centerX: nil, centerY: nil)
        titleDescriptionLabel.anchor(top: self.venueImageView.bottomAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, paddingTop: 0, paddingleft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 40, centerX: nil, centerY: nil)
        descriptionTextLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingleft: 10, paddingBottom: 6, paddingRight: 0, width: 0, height: 30, centerX: nil, centerY: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupMarkerView(){
        marker.position = CLLocationCoordinate2D(latitude:locCoordinate?.latitude ?? 0 , longitude: locCoordinate?.longitude ??  0)
        marker.map = googleMapView
    }
    fileprivate func setNewMarkerLocation( latitude : CLLocationDegrees , longitude : CLLocationDegrees){
        let locCoordinate = CLLocationCoordinate2DMake(latitude, longitude)
        self.marker.position = locCoordinate
        self.googleMapView.camera = GMSCameraPosition.camera(withLatitude: locCoordinate.latitude , longitude: locCoordinate.longitude, zoom: 16)
        let update = GMSCameraUpdate.zoom(by: 0)
        self.googleMapView.animate(with: update)
    }
    
}
