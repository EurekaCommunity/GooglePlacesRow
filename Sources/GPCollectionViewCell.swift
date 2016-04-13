//
//  GPCollectionViewCell.swift
//  GooglePlacesRow
//
//  Created by Mathias Claassen on 4/14/16.
//
//

import Foundation
import GoogleMaps
import Eureka


public protocol EurekaGooglePlacesCollectionViewCell {
    func setText(prediction: GMSAutocompletePrediction)
    func sizeThatFits() -> CGSize
}

/// Default cell for the inputAccessoryView of the GooglePlacesRow
public class GPCollectionViewCell: UICollectionViewCell, EurekaGooglePlacesCollectionViewCell {
    public var label = UILabel()
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        label.font = UIFont.systemFontOfSize(13)
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.blueColor()
        contentView.addSubview(label)
        contentView.backgroundColor = UIColor.whiteColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(4)-[label]-(4)-|", options: [], metrics: nil, views: ["label": label]))
        contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]|", options: [], metrics: nil, views: ["label": label]))
    }
    
    public func setText(prediction: GMSAutocompletePrediction) {
        label.text = prediction.attributedFullText.string
    }
    
    public func sizeThatFits() -> CGSize {
        label.frame = CGRectMake(0, 0, 180, 40)
        label.sizeToFit()
        return CGSizeMake(label.frame.width + 8, 40)
    }
}