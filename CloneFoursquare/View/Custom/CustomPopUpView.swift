//
//  CustomPopUpView.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 29.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation
import UIKit

protocol CustomPopUpViewDelegate : NSObjectProtocol {
    func customPopUpViewWillOpen (_ customPopUpView : UIView)
    func customPopUpViewDidOpen (_ customPopUpView : UIView)
    func customPopUpViewWillClose (_ customPopUpView : UIView)
    func customPopUpViewDidClose (_ customPopUpView : UIView)
}
protocol CustomPopUpViewDataSource : NSObjectProtocol {
    func widhtContainerView() -> CGFloat
    func heightContainerView() -> CGFloat
    func containerContentView() -> UIView
    func constantContainerContentView() -> UIEdgeInsets
}

class CustomPopUpView: UIView {
    
    weak var delegate : CustomPopUpViewDelegate?
    weak var datasource : CustomPopUpViewDataSource?
    
    private var heightContentView : CGFloat?
    private var widhtContentView : CGFloat?
    
    private weak var mainView : UIView!
    
    private let blankView : UIView = {
        let view  = UIView(frame: .zero)
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    private let containerView : UIView = {
        let view  = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    public init(frame: CGRect, mainView: UIView){
        super.init(frame: frame)
        self.mainView = mainView
    }
    fileprivate func startOrganizerView() {
        setupViewInit()
        setupView()
    }
    fileprivate func setupViewInit() {
        guard let datasource = self.datasource else { return  }
        heightContentView = datasource.heightContainerView()
        widhtContentView = datasource.widhtContainerView()
    }
    fileprivate func setupView() {
        setupAddView()
        setupAddConstraint()
        setupStyleContentView()
        addGestureRecognizerBlankView()
    }
    fileprivate func setupAddView(){
        guard let contentView = datasource?.containerContentView() else { return  }
        mainView.addSubview(self)
        self.addSubview(blankView)
        self.addSubview(containerView)
        containerView.addSubview(contentView)
    }
    fileprivate func setupAddConstraint(){
        
        guard let heightContentView = self.heightContentView , let widhtContentView = self.widhtContentView ,let mainView = self.mainView else { return  }
        
        guard let contentView = datasource?.containerContentView()  else { return  }
        
        guard let constantContentView = datasource?.constantContainerContentView() else { return  }
        
        self.anchor(top: mainView.safeAreaLayoutGuide.topAnchor, leading: mainView.leadingAnchor, bottom: mainView.bottomAnchor, trailing: mainView.trailingAnchor, paddingTop: 0, paddingleft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerX: nil, centerY: nil)
        blankView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingleft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerX: nil, centerY: nil)
        
        containerView.anchor(top: nil, leading:nil, bottom:nil, trailing: nil, paddingTop: 0, paddingleft: 0, paddingBottom: 0, paddingRight: 0, width: widhtContentView, height:heightContentView , centerX: mainView.centerXAnchor, centerY: mainView.centerYAnchor)
        
        contentView.anchor(top: self.containerView.topAnchor, leading: self.containerView.leadingAnchor, bottom: self.containerView.bottomAnchor, trailing: self.containerView.trailingAnchor, paddingTop: constantContentView.top, paddingleft:constantContentView.left , paddingBottom: constantContentView.bottom, paddingRight: constantContentView.right, width: 0, height:0, centerX: nil, centerY: nil)
    }
    
    func setupStyleContentView()  {
        guard let heightContentView = self.heightContentView else { return  }
        containerView.layer.cornerRadius = heightContentView * 0.03
        containerView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    }
    func openPopUpMessageView() {
        
        startOrganizerView()
        guard let delegate = self.delegate else { return  }
        
        delegate.customPopUpViewWillOpen(self)
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveLinear, animations: {
            self.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.blankView.alpha = 0.7
        }, completion: { (_) in
            delegate.customPopUpViewDidOpen(self)
        })
    }
    func closePopUpMessageView() {
        
        guard let delegate = self.delegate  else { return  }
        
        delegate.customPopUpViewWillClose(self)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: .curveLinear, animations: {
            self.containerView.transform = CGAffineTransform(scaleX: 0.01, y: 0.001)
            self.blankView.alpha = 0
        }, completion: { (_) in
            delegate.customPopUpViewDidClose(self)
            self.removeFromSuperview()
        })
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var tapGestureRecognizer : UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self , action: #selector(handleGestureRecognizer))
        gesture.numberOfTapsRequired = 1
        return gesture
    }()
    
    fileprivate func addGestureRecognizerBlankView(){
        
        blankView.addGestureRecognizer(tapGestureRecognizer)
        
        blankView.isUserInteractionEnabled = true
    }
    @objc fileprivate func handleGestureRecognizer(){
        closePopUpMessageView()
    }
    
}
