//
//  GPCollectionViewCell.swift
//  GooglePlacesRow
//
//  Created by Mathias Claassen on 4/14/16.
//
//

import Foundation
import GooglePlaces
import Eureka


public protocol EurekaGooglePlacesCollectionViewCell {
    func setText(_ prediction: GMSAutocompletePrediction)
    func sizeThatFits() -> CGSize
}

/// Default cell for the inputAccessoryView of the GooglePlacesRow
open class GPCollectionViewCell: UICollectionViewCell, EurekaGooglePlacesCollectionViewCell {
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
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.8
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.blue
        contentView.addSubview(label)
        contentView.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(4)-[label]-(4)-|", options: [], metrics: nil, views: ["label": label]))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label]|", options: [], metrics: nil, views: ["label": label]))
    }
    
    open func setText(_ prediction: GMSAutocompletePrediction) {
        label.text = prediction.attributedFullText.string
    }
    
    open func sizeThatFits() -> CGSize {
        label.frame = CGRect(x: 0, y: 0, width: 180, height: 40)
        label.sizeToFit()
        return CGSize(width: label.frame.width + 8, height: 40)
    }
}
