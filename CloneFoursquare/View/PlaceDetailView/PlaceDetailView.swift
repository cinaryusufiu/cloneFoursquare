//
//  PlaceDetailView.swift
//  CloneFoursquare
//
//  Created by Yusuf Çınar on 30.05.2019.
//  Copyright © 2019 Yusuf Çınar. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

protocol PlaceDetailViewDataSource  : NSObjectProtocol{
    func numberOfCollectionView()->Int?
    func textForCell(index : Int)->String?
    func locationCoordinate()-> CLLocationCoordinate2D?
    func imageUrlString() -> String?
    func namePlaceDetailViw ()->String?
}
class PlaceDetailView: BaseView {
    
    weak var dataSource : PlaceDetailViewDataSource?
    
    lazy var collectionView : UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 12
        return cv
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
        setupCollectionView()
    }
    fileprivate func setupAddView(){
        self.addSubview(collectionView)
    }
    fileprivate func setupAddConstraint(){
        collectionView.anchor(top: self.safeAreaLayoutGuide.topAnchor, leading: self.safeAreaLayoutGuide.leadingAnchor, bottom: self.safeAreaLayoutGuide.bottomAnchor, trailing: self.safeAreaLayoutGuide.trailingAnchor, paddingTop: 0, paddingleft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0, centerX: nil, centerY: nil)
    }
    fileprivate func setupCollectionView(){
        collectionView.register(PlaceDetailViewCell.self, forCellWithReuseIdentifier: PlaceDetailViewCell.cellId)
        collectionView.register(PlaceDetailHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaceDetailHeaderView.cellId)
    }
}
extension PlaceDetailView : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlaceDetailHeaderView.cellId, for: indexPath) as! PlaceDetailHeaderView
        header.locCoordinate = self.dataSource?.locationCoordinate()
        header.imageUrl = self.dataSource?.imageUrlString()
        header.titleDescriptionLabel.text = self.dataSource?.namePlaceDetailViw()
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 480)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  dataSource?.numberOfCollectionView() ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceDetailViewCell.cellId, for: indexPath) as! PlaceDetailViewCell
        cell.titleDescriptionLabel.text = dataSource?.textForCell(index: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size =  dataSource?.textForCell(index: indexPath.row)?.calculateHeightString(with:collectionView.frame.width - 20 , font: UIFont.boldSystemFont(ofSize: 18))
        return CGSize(width: size?.width ?? 0, height:size?.height  ?? 0 + 100)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}

