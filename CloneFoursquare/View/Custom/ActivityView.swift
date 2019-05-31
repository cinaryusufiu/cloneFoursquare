//
//  ActivityView.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 29.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation
import UIKit
import KRActivityIndicatorView

class ActivityView: UIView {
    
    let activityIndicator : KRActivityIndicatorView = {
        let activ = KRActivityIndicatorView(colors: [.white,.black])
        activ.startAnimating()
        return activ
    }()
    let blankView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        return view
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
        setupAddAnchor()
    }
    fileprivate func setupAddView(){
        self.addSubview(blankView)
        self.addSubview(activityIndicator)
    }
    fileprivate func setupAddAnchor(){
        self.blankView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingleft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerX: nil, centerY: nil)
        self.activityIndicator.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, paddingTop: 0, paddingleft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40, centerX: self.blankView.centerXAnchor, centerY: nil)
        self.activityIndicator.centerYAnchor.constraint(equalTo: self.blankView.centerYAnchor, constant: -100).isActive = true
    }
    
}
