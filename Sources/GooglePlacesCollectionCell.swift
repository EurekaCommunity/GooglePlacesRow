//
//  GooglePlacesCollectionCell.swift
//  GooglePlacesRow
//
//  Created by Mathias Claassen on 4/14/16.
//
//

import Foundation
import UIKit


public class GooglePlacesCollectionCell<CollectionViewCell: UICollectionViewCell where CollectionViewCell: EurekaGooglePlacesCollectionViewCell>: GooglePlacesCell, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// callback that can be used to cuustomize the appearance of the UICollectionViewCell in the inputAccessoryView
    public var customizeCollectionViewCell: (CollectionViewCell -> Void)?
    
    /// UICollectionView that acts as inputAccessoryView.
    public lazy var collectionView: UICollectionView? = {
        let collectionView = UICollectionView(frame: CGRectMake(0, 0, self.contentView.frame.width, 50), collectionViewLayout: self.collectionViewLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        collectionView.registerClass(CollectionViewCell.self, forCellWithReuseIdentifier: self.cellReuseIdentifier)
        return collectionView
    }()
    
    public var collectionViewLayout: UICollectionViewLayout = {
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        return layout
    }()
    
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public override var inputAccessoryView: UIView? {
        return self.collectionView
    }
    
    public override func setup() {
        super.setup()
        
    }
    
    override func reload() {
        collectionView?.reloadData()
    }
    
    //MARK: UICollectionViewDelegate and Datasource
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return predictions?.count ?? 0
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellReuseIdentifier, forIndexPath: indexPath) as! CollectionViewCell
        if let prediction = predictions?[indexPath.row] {
            cell.setText(prediction)
        }
        customizeCollectionViewCell?(cell)
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let prediction = predictions?[indexPath.row] {
            row.value = GooglePlace.Prediction(prediction: prediction)
            cellResignFirstResponder()
        }
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let cell = CollectionViewCell(frame: CGRectZero)
        if let prediction = predictions?[indexPath.row] {
            cell.setText(prediction)
        }
        return cell.sizeThatFits()
    }
    
    public func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
}
