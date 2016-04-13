//
//  iOS.swift
//  GooglePlacesRow
//
//  Copyright © 2016 Xmartlabs SRL. All rights reserved.
//

import Foundation
import Eureka
import GoogleMaps

protocol GooglePlacesRowProtocol {
    func autoComplete(text: String)
}

/**
 The value of the Google Places rows
 
 - UserInput:  The value will be of this type when the user inputs a string and does not select a place suggestion
 - Prediction: The value will be of this type if the user selects an option suggested by requesting autocomplete of the Google Places API.
 */
public enum GooglePlace {
    case UserInput(value: String)
    case Prediction(prediction: GMSAutocompletePrediction)
}

extension GooglePlace: Equatable, InputTypeInitiable {
    public init?(string stringValue: String) {
        self = .UserInput(value: stringValue)
    }
}

public func == (lhs: GooglePlace, rhs: GooglePlace) -> Bool {
    switch (lhs, rhs) {
    case (let .UserInput( val), let .UserInput( val2)):
        return val == val2
    case (let .Prediction( pred), let .Prediction( pred2)):
        if pred.placeID != nil {
            return pred.placeID == pred2.placeID
        }
        return pred2.placeID == nil && pred.attributedFullText == pred2.attributedFullText
    default:
        return false
    }
}

/// Generic GooglePlaces rows superclass
public class _GooglePlacesRow<Cell: GooglePlacesCell where Cell.Value == GooglePlace>: FieldRow<GooglePlace, Cell>, GooglePlacesRowProtocol {
    /// client that connects with Google Places
    private let placesClient = GMSPlacesClient()
    
    /// Google Places filter. Change this to search for cities, addresses, country, etc
    public var placeFilter: GMSAutocompleteFilter?
    
    /// Google Places bounds. Ratio for the results of the filter. Read the official documentation for more
    public var placeBounds: GMSCoordinateBounds?
    
    /// Will be called when Google Places request returns an error.
    public var onNetworkingError: (NSError? -> Void)?

    required public init(tag: String?) {
        super.init(tag: tag)
        placeFilter = GMSAutocompleteFilter()
        placeFilter?.type = .City
        displayValueFor = { place in
            guard let place = place else {
                return nil
            }
            switch place {
            case let GooglePlace.UserInput(val):
                return val
            case let GooglePlace.Prediction(pred):
                return pred.attributedFullText.string
            }
        }
    }

    func autoComplete(text: String) {
        placesClient.autocompleteQuery(text, bounds: placeBounds, filter: placeFilter, callback: { [weak self] (results, error: NSError?) -> Void in
            guard let results = results else {
                self?.onNetworkingError?(error)
                return
            }
            self?.cell.predictions = results
            self?.cell.reload()
        })
    }
}

/// Row that lets the user choose an option from Google Places using Autocomplete. Options are shown in the inputAccessoryView
public final class GooglePlacesAccessoryRow: _GooglePlacesRow<GooglePlacesCollectionCell<GPCollectionViewCell>>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
}

/// Row that lets the user choose an option from Google Places using Autocomplete. Options are shown in a table below the cell
public final class GooglePlacesTableRow: _GooglePlacesRow<GooglePlacesTableCell<GPTableViewCell>>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
}