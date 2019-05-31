//
//  PlacesView.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 30.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation
import UIKit

protocol PlacesViewDataSource : NSObjectProtocol {
    func numberOfRowsInSection() -> Int
    func getVenueModel(index : Int) -> Venue?
}
protocol PlacesViewDelegate : NSObjectProtocol {
    func handleDidSelectRowAt(index : Int)
}
class PlacesView: BaseView {
    
    weak var dataSource :PlacesViewDataSource?
    weak var delegate : PlacesViewDelegate?
    
    lazy var tableView : UITableView = {
        let tb = UITableView(frame: .zero, style: .plain)
        tb.backgroundColor = .white
        tb.delegate = self
        tb.dataSource = self
        return tb
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    fileprivate func setupView(){
        setupAddView()
        setupAddConstraint()
        setupTableView()
    }
    fileprivate func setupAddView(){
        addSubview(tableView)
    }
    fileprivate func setupAddConstraint(){
        tableView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingleft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerX: nil, centerY: nil)
    }
    fileprivate func setupTableView(){
        tableView.register(PlaceTableViewCell.self, forCellReuseIdentifier: PlaceTableViewCell.cellId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("PlacesView")
    }
   
}
extension PlacesView  : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.cellId, for: indexPath) as! PlaceTableViewCell
        cell.venue = self.dataSource?.getVenueModel(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return  }
        delegate.handleDidSelectRowAt(index: indexPath.row)
    }
    
}
