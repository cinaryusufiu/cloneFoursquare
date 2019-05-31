//
//  ViewController.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 29.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
   
    lazy var searchViewModel : SearchViewModel = {
        let viewModel = SearchViewModel()
        viewModel.delegate = self
        return viewModel
    }()
    lazy var searchView : SearchView = {
       let view = SearchView(frame: .zero)
        view.delegate = self
       return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    //MARK:Setup Functions
    fileprivate func setupView(){
        setupAddView()
        setupAddConstraint()
        setupNavigationBar()
    }
    fileprivate func setupAddView(){
        self.view.addSubview(searchView)
    }
    fileprivate func setupAddConstraint(){
        
        searchView.anchor(top: self.view.topAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, paddingTop: 0, paddingleft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerX: nil, centerY: nil)
    }
    fileprivate func setupNavigationBar(){
       self.navigationItem.title = searchViewModel.getNavigationTitle()
    }


}
extension SearchViewController : SearchViewDelegate, SearchViewModelDelegate {
    
    //MARK:SearchViewModelDelegate
    func startHud() {
        searchView.addActivityIndicatorView()
    }
    func stopHud() {
        searchView.removeActivityIndicatorView()
    }
    func openPlacesViewPage(venues: [Venue]) {
        stopHud()
        let placesViewController = PlacesViewController(placesViewModel: PlacesViewModel(venues: venues))
        self.navigationController?.pushViewController(placesViewController, animated: true)
        print("openPlacesViewPage")
    }
    func errorDataApi() {
        stopHud()
        print("errorDataApi")
    }
    func emptyData() {
        stopHud()
        openAlerController(title: "Empty Data", message: "in foursquare data not found ")
        print("emptyData")
    }
    //MARK:SearchViewDelegate
    func onClickedSearchButton(venue: String, location: String?) {
        startHud()
        searchViewModel.handleSendButton(query: venue, location:location )
    }
    
    func openAlerController(title : String , message : String) {
        stopHud()
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true, completion: nil)
    }
}

