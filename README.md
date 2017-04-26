
<p align="left">
<!--<a href="https://travis-ci.org/EurekaCommunity/GooglePlacesRow"><img src="https://travis-ci.org/EurekaCommunity/GooglePlacesRow.svg?branch=master" alt="Build status" /></a>-->
<img src="https://img.shields.io/badge/platform-iOS-blue.svg?style=flat" alt="Platform iOS" />
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift2-compatible-4BC51D.svg?style=flat" alt="Swift 2 compatible" /></a>
<a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift3-compatible-4BC51D.svg?style=flat" alt="Swift 2 compatible" /></a>
<a href="https://cocoapods.org/pods/GooglePlacesRow"><img src="https://img.shields.io/cocoapods/v/GooglePlacesRow.svg" alt="CocoaPods compatible" /></a>
<a href="https://raw.githubusercontent.com/EurekaCommunity/GooglePlacesRow/master/LICENSE"><img src="http://img.shields.io/badge/license-MIT-blue.svg?style=flat" alt="License: MIT" /></a>
</p>

By [Xmartlabs SRL](http://EurekaCommunity.com).

**Current Google Places version used is 2.0.1**

**Swift 3 is supported from version 2.0**

## Contents

* [Introduction](#introduction)
* [Usage](#usage)
* [Dependencies](#dependencies)
* [Requirements](#requirements)
* [Getting involved](#getting-involved)
* [Examples](#examples)
* [Installation](#installation)
* [Customization](#customization)
* [FAQ](#faq)

## Introduction

GooglePlacesRow is a row extension for Eureka. It implements a row where the user can use Google Places autocomplete functionality to select a place suggested by the API.

GooglePlacesRow includes two rows with similar functionality but their options are displayed diferently:
* GooglePlacesAccessoryRow: displays a collection view as the `inputAccessoryView` of the cell. The user will be able to scroll horizontally to select the desired place
* GooglePlacesTableRow: displays a `UITableView` directly below the cell for the user to choose the desired option.

The project is experimental and open to changes although it is already quite customizable.



Please follow the [installation instructions](#installation)

 <img src="Example/GooglePlacesGif.gif" width="300"/>

## Usage

```swift
// in AppDelegate.swift
import GoogleMaps

// then in application:didFinishLaunchingWithOptions:
let apiKey = "YOUR_API_KEY"
GMSServices.provideAPIKey(apiKey)


//in your subclass of FormViewController
form +++ Section("Choose from table view")
            <<< GooglePlacesTableRow()
     +++ Section("Customized cell, customized layout")
         <<< GooglePlacesAccessoryRow().cellSetup { cell, row in
             (cell.collectionViewLayout  as? UICollectionViewFlowLayout)?.sectionInset = UIEdgeInsetsZero
             (cell.collectionViewLayout  as? UICollectionViewFlowLayout)?.minimumInteritemSpacing = 40
             cell.customizeCollectionViewCell = { cvcell in
                 cvcell.label.textColor = UIColor.redColor()
                 cvcell.layer.borderColor = UIColor.redColor().CGColor
                 cvcell.layer.borderWidth = 1
                 cvcell.layer.cornerRadius = 4
                 }
        }
```

To see what you can customize have a look at the [Customization](#customization) section or the [FAQ](#faq)

## Dependencies
* Eureka (obviously)
* GooglePlaces (and all the frameworks it depends on)
* GoogleMapsBase

## Requirements

* iOS 8.0+
* Xcode 8.3+

## Getting involved

* If you **want to contribute** please feel free to **submit pull requests**.
* If you **have a feature request** please **open an issue**.
* If you **found a bug** or **need help** please **check older issues or the [FAQ](#faq) before submitting an issue.**.

Before contributing check the [CONTRIBUTING](https://github.com/EurekaCommunity/GooglePlacesRow/blob/master/CONTRIBUTING.md) file for more info.

If you use **GooglePlacesRow** in your app we would love to hear about it! Drop us a line on [twitter](https://twitter.com/EurekaCommunity).

## Examples

### For Swift 2 (1.0.1 or before)

Follow these steps to run Example project:
* Clone GooglePlacesRow repository
* Run `carthage update` in the root of the project
* Open GooglePlacesRow workspace
* **Set your Google places API KEY in `AppDelegate.swift`**
* and run the *Example* project.

### For Swift 3

Follow these steps to run Example project:
* Clone GooglePlacesRow repository
* Execute `git submodule add https://github.com/xmartlabs/Eureka.git` in the cloned folder.
* Open GooglePlacesRow workspace
* **Set your Google places API KEY in `AppDelegate.swift`**
* and run the *Example* project.


## Installation

#### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects.

To install GooglePlacesRow, simply add the following line to your Podfile:

```ruby
pod 'GooglePlacesRow'
```

Then you have to tell Xcode where the Google Places framework is. The easiest way to do it is by adding `$(PROJECT_DIR)/Pods/GooglePlacesRow/Frameworks` to the `Build Settings/Framework Search Paths` of your target.

> Note: Do not add `pod 'GooglePlaces'` to your podfile as this library includes it as a vendored framework

<!--#### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a simple, decentralized dependency manager for Cocoa.

To install GooglePlacesRow, simply add the following line to your Cartfile:

```ogdl
github "EurekaCommunity/GooglePlacesRow"
```-->

## Customization

### General customization
There are five variables that you can use to modify the default behaviour of these rows:

* In the row:
	* `placeFilter`: Is a `GMSAutocompleteFilter` used in the request to Google Places to define what kind of suggestions will be returned (e.g. cities, addresses, country). Refer to the official docummentation of Google for more detailed information.
	* `placeBounds`: Bounds to limit the search for places. Refer to the official docummentation of Google for more detailed information.
	* `onNetworkingError`: Block that is called when the request to Google Places returns an error
* In the cell:
	* `useTimer`: If the request to Google Places should be throttled using a timer. If `true` then it will wait for `timerInterval` seconds before making a request. If the user continues entering text into the row then the previous request will not be fired
	* `timerInterval`: The interval in seconds used for the timer explained above

### GooglePlacesAccessoryRow
GooglePlacesAccessoryRow uses a generic `GooglePlacesCollectionCell` cell whose generic parameter is the UICollectionViewCell class used in the inputAccessoryView.

* If you just want to change minor things of the cell (you most probably will want to) then the `customizeCollectionViewCell` callback is for you. This block is called in the delegates `collectionView:cellForItemAtIndexPath:` method.

* If you want to change the **layout of the collectionView** then you can use/modify/override the `collectionViewLayout` attribute in the `cellSetup` method when declaring the row. Have a look at the examples for this.

* If you want to change something about the **collectionView** (e.g. its height, backgroundColor) then you can also do that in the `cellSetup` method. Have a look at the examples for this.

* If you want to **change the collection view cell of the inputAccessoryView** drastically then there is nothing easier than creating your own row (`MyGooglePlacesAccessoryRow`) with your own `MyCollectionViewCell`:
```swift
public final class MyGooglePlacesAccessoryRow: _GooglePlacesRow<GooglePlacesCollectionCell<MyCollectionViewCell>>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
}
```
In this case just make sure your cell conforms to `EurekaGooglePlacesCollectionViewCell`

### GooglePlacesTableRow
GooglePlacesTableRow uses a generic `GooglePlacesTableCell` cell whose generic parameter is the UITableViewCell class used to create the cells displayed in a UITableView with the suggested options from Google Places.

* If you just want to change minor things of the cells that display the options (you will most probably want to) then the `customizeTableViewCell` callback is for you. This block is called in the delegates `tableView:cellForRowAtIndexPath:` method.

* You can customize attributes of the `tableView` that is displayed with the options. You should do this in `cellSetup` and keep in mind that the frame of the tableView is reset each time the tableView is displayed.

* If you want to change these cells drastically then there is nothing easier than creating your own row (`MyGooglePlacesAccessoryRow`) with your own `MyCollectionViewCell`:
```swift
public final class MyGooglePlacesAccessoryRow: _GooglePlacesRow<GooglePlacesCollectionCell<MyCollectionViewCell>>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
}
```
In this case just make sure your cell conforms to `EurekaGooglePlacesTableViewCell`

## FAQ

#### Xcode says `ld: framework not found GoogleMaps for architecture x86_64`.

This is most probalby because you forgot to tell Xcode where `GoogleMapsBase.framework` or `GooglePlaces.framework` is or you did forget to download it altogether. Please follow the [example instructions](#examples) or the [installation instructions](#installation).

## Future work
* Carthage compatibility
* Investigate automation of the installation process



## Author

* [Mathias Claassen](https://github.com/mats-claassen) ([@mClaassen26](https://twitter.com/mClaassen26)) ([@EurekaCommunity](https://twitter.com/EurekaCommunity))

# Change Log

This can be found in the [CHANGELOG.md](CHANGELOG.md) file.
