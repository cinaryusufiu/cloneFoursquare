//
//  BaseView.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 30.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation
import UIKit

class BaseView: UIView {
    
    let activityView : ActivityView = {
        let activ = ActivityView(frame: .zero)
        return activ
    }()
     internal func addActivityIndicatorView(){
        self.addSubview(activityView)
        activityView.frame = self.frame
    }
    internal func removeActivityIndicatorView(){
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveLinear, animations: {
            self.activityView.removeFromSuperview()
        })
    }
}
