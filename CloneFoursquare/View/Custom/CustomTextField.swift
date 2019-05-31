//
//  CustomTextField.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 29.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    let insetLeft :CGFloat = 12
    let insetTop :CGFloat = 4
    let insetBottom :CGFloat = 4
    let insertRight: CGFloat = 0
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        
        return bounds.inset(by: UIEdgeInsets(top: insetTop, left: insetLeft, bottom: insetBottom , right: insertRight))
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
      
        return bounds.inset(by: UIEdgeInsets(top: insetTop, left: insetLeft, bottom: insetBottom , right: insertRight))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView(){
        self.layer.cornerRadius = 8
        self.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        self.backgroundColor = .white
        self.borderStyle = .none
    }
}
