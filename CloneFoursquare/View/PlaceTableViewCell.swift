//
//  PlaceTableViewCell.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 30.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation
import UIKit

class PlaceTableViewCell: UITableViewCell {
   
    static let cellId = "PlaceTableViewCellId"
    var venue : Venue? {
        didSet{
            guard let venue = self.venue  else { return }
            titleTextLabel.text = venue.name
            cityTextLabel.text = venue.location?.city
            addressTextLabel.text = venue.location?.address
            countryTextLabel.text = venue.location?.country
        }
    }
    let titleTextLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .purple
        return label
    }()
    let cityTextLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    let addressTextLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    let countryTextLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font =  UIFont.systemFont(ofSize: 11, weight: .semibold)
        label.textAlignment = .right
        label.textColor = .black
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupView(){
        setupAddView()
        setupAddConstraint()
    }
    fileprivate func setupAddView(){
        self.addSubview(titleTextLabel)
        self.addSubview(cityTextLabel)
        self.addSubview(addressTextLabel)
        self.addSubview(countryTextLabel)
    }
    fileprivate func setupAddConstraint(){
        self.titleTextLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, paddingTop: 10, paddingleft: 14, paddingBottom: 0, paddingRight: 14, width: 0, height: 0, centerX: nil, centerY: nil)
        self.cityTextLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing:  self.trailingAnchor, paddingTop: 0, paddingleft: 14, paddingBottom: 10, paddingRight: 14, width: 0, height: 0, centerX: nil, centerY: nil)
        self.addressTextLabel.anchor(top:nil, leading: self.leadingAnchor, bottom: self.cityTextLabel.topAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingleft: 14, paddingBottom: 5, paddingRight: 14, width: 0, height: 0, centerX: nil, centerY: nil)
        self.countryTextLabel.anchor(top: nil, leading:  self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingleft: 14, paddingBottom: 10, paddingRight: 14, width: 0, height: 0, centerX: nil, centerY: nil)
    }
}
