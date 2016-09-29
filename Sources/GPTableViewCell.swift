//
//  GPTableViewCell.swift
//  GooglePlacesRow
//
//  Created by Mathias Claassen on 4/14/16.
//
//

import Foundation
import GooglePlaces
import Eureka

public protocol EurekaGooglePlacesTableViewCell {
    func setTitle(_ prediction: GMSAutocompletePrediction)
}

/// Default cell for the table of the GooglePlacesTableCell
open class GPTableViewCell: UITableViewCell, EurekaGooglePlacesTableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        textLabel?.font = UIFont.systemFont(ofSize: 16)
        textLabel?.minimumScaleFactor = 0.8
        textLabel?.adjustsFontSizeToFitWidth = true
        textLabel?.textColor = UIColor.blue
        contentView.backgroundColor = UIColor.white
    }
    
    open func setTitle(_ prediction: GMSAutocompletePrediction) {
        textLabel?.text = prediction.attributedFullText.string
    }
}
