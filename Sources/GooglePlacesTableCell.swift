//
//  GooglePlacesTableCell.swift
//  GooglePlacesRow
//
//  Created by Mathias Claassen on 4/14/16.
//
//

import Foundation
import UIKit

public class GooglePlacesTableCell<TableViewCell: UITableViewCell where TableViewCell: EurekaGooglePlacesTableViewCell>: GooglePlacesCell, UITableViewDelegate, UITableViewDataSource {
    
    /// callback that can be used to cuustomize the appearance of the UICollectionViewCell in the inputAccessoryView
    public var customizeTableViewCell: (TableViewCell -> Void)?
    
    /// UICollectionView that acts as inputAccessoryView.
    public var tableView: UITableView?

    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public override func setup() {
        super.setup()
        tableView = UITableView(frame: CGRectZero, style: .Plain)
        tableView?.autoresizingMask = .FlexibleHeight
        tableView?.hidden = true
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = UIColor.whiteColor()
        tableView?.registerClass(TableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    public func showTableView() {
        
        if let controller = formViewController() {
            if tableView?.superview == nil {
                controller.view.addSubview(tableView!)
            }
            let frame = controller.tableView?.convertRect(self.frame, toView: controller.view) ?? self.frame
            tableView?.frame = CGRectMake(0, frame.origin.y + frame.height, contentView.frame.width, 44*5)
            tableView?.hidden = false
        }
    }
    
    public func hideTableView() {
        tableView?.hidden = true
    }
    
    override func reload() {
        tableView?.reloadData()
    }
    
    public override func textFieldDidChange(textField: UITextField) {
        super.textFieldDidChange(textField)
        if textField.text?.isEmpty == false {
            showTableView()
        }
    }
    
    public override func unhighlight() {
        super.unhighlight()
        hideTableView()
    }
    
    //MARK: UITableViewDelegate and Datasource
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictions?.count ?? 0
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as! TableViewCell
        if let prediction = predictions?[indexPath.row] {
            cell.setTitle(prediction)
        }
        customizeTableViewCell?(cell)
        return cell
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let prediction = predictions?[indexPath.row] {
            row.value = GooglePlace.Prediction(prediction: prediction)
            cellResignFirstResponder()
        }
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}