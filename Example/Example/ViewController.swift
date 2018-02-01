//
//  ViewController.swift
//  Example
//
//  Copyright © 2016 Xmartlabs SRL. All rights reserved.
//

import UIKit
import GooglePlacesRow
import Eureka
import GooglePlaces

class ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.form = Form()
        +++ Section("Default row")
            <<< GooglePlacesAccessoryRow("default(1)")
        +++ Section("Choose from table view")
            <<< GooglePlacesTableRow("tableview(2)"){
                $0.onNetworkingError = { error in
                    print(error ?? "There was a netwrok error")
                }
            }
        +++ Section("Customized cell, customized layout")
            <<< GooglePlacesAccessoryRow("customized(3)").cellSetup { cell, row in
                (cell.collectionViewLayout  as? UICollectionViewFlowLayout)?.sectionInset = UIEdgeInsets.zero
                (cell.collectionViewLayout  as? UICollectionViewFlowLayout)?.minimumInteritemSpacing = 40
                cell.customizeCollectionViewCell = { cvcell in
                    cvcell.label.textColor = .red
                    cvcell.layer.borderColor = UIColor.red.cgColor
                    cvcell.layer.borderWidth = 1
                    cvcell.layer.cornerRadius = 4
                }
        }
        +++ Section("Big collection view with addresses")
            <<< GooglePlacesAccessoryRow("address(4)"){ row in
                    row.title = "Address:"
                    row.placeFilter?.type = .address
                }.cellSetup { cell, row in
                cell.collectionView?.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: 100)
        }
        +++ Section()
            <<< LabelRow(){ row in
                row.title = "Print values to console"
                }.cellSetup { cell, row in
                    cell.textLabel?.textAlignment = .center
                }.onCellSelection { cell, row in
                    for (tag, value) in row.section?.form?.values() ?? [:] {
                        if let val = value {
                           print("row \(tag) = \(val)")
                        } else {
                            print("row \(tag) = nil")
                        }
                    }
                    print("------------------------------")
                }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

