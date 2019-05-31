//
//  PlaceViewController.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 30.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class PlacesViewController: UIViewController  {
    
    lazy var  placeDetailView : PlaceDetailView = {
       let view = PlaceDetailView(frame: .zero)
        view.layer.cornerRadius = 20
        view.dataSource = self
        return view
    }()
    lazy var customPopUpView : CustomPopUpView = {
        let view = CustomPopUpView(frame: .zero, mainView: self.placesView)
        view.delegate = self
        view.datasource = self
        return view
    }()
    lazy var  placesView : PlacesView = {
       let view = PlacesView(frame: .zero)
        view.dataSource = self
        view.delegate = self
     return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationBar()
    }
    fileprivate func setupNavigationBar(){
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.title = placesViewModel.getNavigationTitle()
    }
    var placesViewModel : PlacesViewModel!
    
    init(placesViewModel : PlacesViewModel?) {
       super.init(nibName: nil, bundle: nil)
        
    }
    convenience init(placesViewModel: PlacesViewModel) {
        self.init(placesViewModel: nil)
        setupInitilaze(placesViewModel: placesViewModel)
    }
    convenience init() {
        self.init(placesViewModel: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    fileprivate func setupInitilaze(placesViewModel : PlacesViewModel?){
        guard let placesViewM = placesViewModel else { return  }
        placesViewM.delegate = self
        self.placesViewModel = placesViewM
    }
    fileprivate func setupView(){
        setupAddView()
        setupAddConstraint()
    }
    fileprivate func setupAddView(){
        self.view.addSubview(placesView)
        self.view.backgroundColor = .white
    }
    fileprivate func setupAddConstraint(){
       self.placesView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, paddingTop: 0, paddingleft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerX: nil, centerY: nil)
    }
    
   
}
extension PlacesViewController :  PlacesViewDataSource , PlacesViewDelegate,PlacesViewModelDelegate , PlaceDetailViewDataSource {
    
    //MARK:PlaceViewDataSource
    func numberOfRowsInSection() -> Int {
        return  placesViewModel.getVenus().count
    }
    func getVenueModel(index: Int) -> Venue? {
        if index >= placesViewModel.getVenus().count{
            return nil
        }
        return placesViewModel.getVenus()[index]
    }
    //MARK:PlaceViewDelegate
    func handleDidSelectRowAt(index: Int) {
        
        placesView.addActivityIndicatorView()
        placesViewModel.onClickedCell(index: index)
    }
    func reloadPlaceViewDetail() {
        
    }
    func openPlaceDetailView() {
        placesView.removeActivityIndicatorView()
        placeDetailView.collectionView.reloadData()
        customPopUpView.openPopUpMessageView()
        print("openPlaceDetailView")
    }
    func errorGetDetailVenue() {
        
        placesView.removeActivityIndicatorView()
        self.openAlerController(title: "Error", message: "error api")
    }
    func openAlerController(title : String , message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
    //MARK:PlaceDetailViewDataSource
    
    func numberOfCollectionView() -> Int? {
        return placesViewModel.numberOfCollectionViewPlaceDetail()
    }
    func textForCell(index : Int)->String?{
        return placesViewModel.textForCellPlaceDetail(index: index)
    }
    func locationCoordinate() -> CLLocationCoordinate2D? {
        return placesViewModel.locationCoordinate()
    }
    func imageUrlString() -> String? {
        return placesViewModel.imageUrlStringPlaceDetail()
    }
    func namePlaceDetailViw() -> String? {
        return placesViewModel.selectedVenue?.name
    }
}
extension PlacesViewController : CustomPopUpViewDelegate , CustomPopUpViewDataSource {
    func customPopUpViewWillOpen(_ customPopUpView: UIView) {
        print("customPopUpViewWillOpen")
    }
    
    func customPopUpViewDidOpen(_ customPopUpView: UIView) {
         print("customPopUpViewDidOpen")
    }
    
    func customPopUpViewWillClose(_ customPopUpView: UIView) {
         print("customPopUpViewWillClose")
    }
    
    func customPopUpViewDidClose(_ customPopUpView: UIView) {
        print("customPopUpViewDidClose")
    }
    
    func widhtContainerView() -> CGFloat {
        return self.view.frame.width - 40
    }
    
    func heightContainerView() -> CGFloat {
        return  self.view.frame.height * 0.7
    }
    
    func containerContentView() -> UIView {
        return placeDetailView
    }
    
    func constantContainerContentView() -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
