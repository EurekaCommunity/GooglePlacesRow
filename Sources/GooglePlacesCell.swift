//
//  GooglePlacesCell.swift
//  GooglePlacesRow
//
//  Created by Mathias Claassen on 4/13/16.
//
//

import Foundation
import UIKit
import Eureka
import GooglePlaces

/// This is the general cell for the GooglePlacesCell. Create a subclass or use GooglePlacesCollectionCell or GooglePlacesTableCell instead.
open class GooglePlacesCell: _FieldCell<GooglePlace>, CellType {
    
    /// Defines if the cell should wait for a moment before requesting places from google when the user edits the textField
    open var useTimer = true
    
    /// The interval to wait before requesting places from Google if useTimer = true
    open var timerInterval = 0.3
    
    
    //MARK: Private / internal
    let cellReuseIdentifier = "Eureka.GooglePlaceCellIdentifier"
    var predictions: [GMSAutocompletePrediction]?
    
    fileprivate var autocompleteTimer: Timer?
    
    //MARK: Methods
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func setup() {
        super.setup()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
    }
    
    //MARK: UITextFieldDelegate
    open override func textFieldDidBeginEditing(_ textField: UITextField) {
        formViewController()?.beginEditing(of: self)
        formViewController()?.textInputDidBeginEditing(textField, cell: self)
        textField.selectAll(nil)
    }
    
    open override func textFieldDidChange(_ textField: UITextField) {
        super.textFieldDidChange(textField)
        if useTimer {
            if let timer = autocompleteTimer {
                timer.invalidate()
                autocompleteTimer = nil
            }
            autocompleteTimer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(GooglePlacesCell.timerFired(_:)), userInfo: nil, repeats: false)
        } else {
            autocomplete()
        }
    }
    
    open override func textFieldDidEndEditing(_ textField: UITextField) {
        formViewController()?.endEditing(of: self)
        formViewController()?.textInputDidEndEditing(textField, cell: self)
        textField.text = row.displayValueFor?(row.value)
    }
    
    fileprivate func autocomplete() {
        if let text = textField.text , !text.isEmpty {
            (row as? GooglePlacesRowProtocol)?.autoComplete(text)
        } else {
            predictions?.removeAll()
            reload()
        }
    }
    
    func reload() {}
    
    /**
     Function called when the Google Places autocomplete timer is fired
     */
    func timerFired(_ timer: Timer?) {
        autocompleteTimer?.invalidate()
        autocompleteTimer = nil
        autocomplete()
    }
}
