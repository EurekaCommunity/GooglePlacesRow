//
//  GooglePlacesCollectionCell.swift
//  GooglePlacesRow
//
//  Created by Mathias Claassen on 4/14/16.
//
//

import Foundation
import UIKit


open class GooglePlacesCollectionCell<CollectionViewCell: UICollectionViewCell>: GooglePlacesCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout where CollectionViewCell: EurekaGooglePlacesCollectionViewCell {
    
    /// callback that can be used to cuustomize the appearance of the UICollectionViewCell in the inputAccessoryView
    public var customizeCollectionViewCell: ((CollectionViewCell) -> Void)?
    
    /// UICollectionView that acts as inputAccessoryView.
    public lazy var collectionView: UICollectionView? = {
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: 50), collectionViewLayout: self.collectionViewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: self.cellReuseIdentifier)
        return collectionView
    }()
    
    public var collectionViewLayout: UICollectionViewLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        return layout
    }()
    
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override var inputAccessoryView: UIView? {
        return self.collectionView
    }
    
    open override func setup() {
        super.setup()
        
    }
    
    override func reload() {
        collectionView?.reloadData()
    }
    
    //MARK: UICollectionViewDelegate and Datasource
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return predictions?.count ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CollectionViewCell
        if let prediction = predictions?[(indexPath as NSIndexPath).row] {
            cell.setText(prediction)
        }
        customizeCollectionViewCell?(cell)
        return cell
    }
    
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let prediction = predictions?[(indexPath as NSIndexPath).row] {
            row.value = GooglePlace.prediction(prediction: prediction)
            _ = cellResignFirstResponder()
        }
    }
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = CollectionViewCell(frame: CGRect.zero)
        if let prediction = predictions?[(indexPath as NSIndexPath).row] {
            cell.setText(prediction)
        }
        return cell.sizeThatFits()
    }
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
