//
//  String-Extension.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 30.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation
import UIKit

extension String {
    public var isAlphanumeric: Bool {
        guard !isEmpty else {
            return false
        }
        //remove
        let allowed = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let characterSet = CharacterSet(charactersIn: allowed)
        guard rangeOfCharacter(from: characterSet.inverted) == nil else {
            return false
        }
        return true
    }
    func calculateHeightString(with width : CGFloat , font : UIFont) -> CGRect{
        
        let size = CGSize(width:  width, height: 9999)
        let option =  NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedRect = NSString(string: self).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font :font], context: nil)
        return estimatedRect
    }
    
}
