//
//  SearchView.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 29.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation
import UIKit
protocol SearchViewDelegate: NSObjectProtocol {
    func onClickedSearchButton(venue : String , location : String?)
    func openAlerController(title : String , message : String)
}

class SearchView: BaseView {
    
    weak var delegate : SearchViewDelegate?
    
    lazy var venueEntryTextField : CustomTextField = {
        let textField = CustomTextField(frame: .zero)
        textField.placeholder = "Exp.Cafe,Bar"
        textField.textColor = .black
        return textField
    }()
    lazy var locationEntryTextfield : CustomTextField = {
        let textField = CustomTextField(frame: .zero)
        textField.placeholder = "Close to me"
        textField.textColor = .black
        return textField
    }()
    lazy var searchButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.imageView?.clipsToBounds = true
        button.contentHorizontalAlignment = .center
        button.backgroundColor = .purple
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(handleSearchButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor  = .lightText
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
        addSubview(venueEntryTextField)
        addSubview(locationEntryTextfield)
        addSubview(searchButton)
    }
    fileprivate func setupAddConstraint(){
        
        let height :CGFloat = 48
        let padding : CGFloat = 20
        locationEntryTextfield.anchor(top: nil, leading: safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingleft: padding, paddingBottom: 0, paddingRight: padding, width: 0, height: height, centerX: nil, centerY: centerYAnchor)
        venueEntryTextField.anchor(top: nil, leading: locationEntryTextfield.leadingAnchor, bottom: locationEntryTextfield.topAnchor, trailing: locationEntryTextfield.trailingAnchor, paddingTop: 0, paddingleft: 0, paddingBottom: padding, paddingRight: 0, width: 0, height: height, centerX: nil, centerY: nil)
        searchButton.anchor(top: locationEntryTextfield.bottomAnchor, leading: locationEntryTextfield.leadingAnchor, bottom: nil, trailing: locationEntryTextfield.trailingAnchor, paddingTop: padding, paddingleft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: height, centerX: nil, centerY: nil)
    }
    @objc func handleSearchButton(){
        print("handleSearchButton")
        guard  let venueStringValue = venueEntryTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) , venueStringValue.count >= 3 else {
             delegate?.openAlerController(title: "Error Empty", message: "Should be at least be 3 characters ")
            return }
        if venueStringValue.isAlphanumeric  {
            startSearching()
            return
        }
        openAlerForErrorAlphanumeric()
    }
    fileprivate func startSearching(){
        guard let delegate = self.delegate ,  let venue = venueEntryTextField.text else { return }
        delegate.onClickedSearchButton(venue:venue, location: locationEntryTextfield.text)
    }
    fileprivate func openAlerForErrorAlphanumeric(){
        guard let delegate = self.delegate else { return }
        delegate.openAlerController(title: "Error isAlphanumeric", message: "Should be Alphanumeric ")
    }
    
}

