//
//  PlaceDetailViewCell.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 31.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation
import UIKit
class PlaceDetailViewCell: UICollectionViewCell{
    
    static let cellId = "cellId"
    
    let titleDescriptionLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        self.addSubview(titleDescriptionLabel)
    }
    fileprivate func setupAddConstraint(){
        self.backgroundColor = .red
        titleDescriptionLabel.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingleft: 4, paddingBottom: 0, paddingRight: 4, width: 0, height: 0, centerX: nil, centerY: nil)
    }
}
