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
import GoogleMaps

/// This is the general cell for the GooglePlacesCell. Create a subclass or use GooglePlacesCollectionCell or GooglePlacesTableCell instead.
public class GooglePlacesCell: _FieldCell<GooglePlace>, CellType {
    
    /// Defines if the cell should wait for a moment before requesting places from google when the user edits the textField
    public var useTimer = true
    
    /// The interval to wait before requesting places from Google if useTimer = true
    public var timerInterval = 0.3
    
    
    //MARK: Private / internal
    let cellReuseIdentifier = "Eureka.GooglePlaceCellIdentifier"
    var predictions: [GMSAutocompletePrediction]?
    
    private var autocompleteTimer: NSTimer?
    
    //MARK: Methods
    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    override public func setup() {
        super.setup()
        textField.autocorrectionType = .No
        textField.autocapitalizationType = .Words
    }
    
    //MARK: UITextFieldDelegate
    public override func textFieldDidBeginEditing(textField: UITextField) {
        formViewController()?.beginEditing(self)
        formViewController()?.textInputDidBeginEditing(textField, cell: self)
        textField.selectAll(nil)
    }
    
    public override func textFieldDidChange(textField: UITextField) {
        super.textFieldDidChange(textField)
        if useTimer {
            if let timer = autocompleteTimer {
                timer.invalidate()
                autocompleteTimer = nil
            }
            autocompleteTimer = NSTimer.scheduledTimerWithTimeInterval(0.3, target: self, selector: #selector(GooglePlacesCell.timerFired(_:)), userInfo: nil, repeats: false)
        } else {
            autocomplete()
        }
    }
    
    public override func textFieldDidEndEditing(textField: UITextField) {
        formViewController()?.endEditing(self)
        formViewController()?.textInputDidEndEditing(textField, cell: self)
        textField.text = row.displayValueFor?(row.value)
    }
    
    private func autocomplete() {
        if let text = textField.text where !text.isEmpty {
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
    func timerFired(timer: NSTimer?) {
        autocompleteTimer?.invalidate()
        autocompleteTimer = nil
        autocomplete()
    }
}
