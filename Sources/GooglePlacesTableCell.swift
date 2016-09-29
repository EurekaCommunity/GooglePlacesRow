//
//  GooglePlacesTableCell.swift
//  GooglePlacesRow
//
//  Created by Mathias Claassen on 4/14/16.
//
//

import Foundation
import UIKit

open class GooglePlacesTableCell<TableViewCell: UITableViewCell>: GooglePlacesCell, UITableViewDelegate, UITableViewDataSource where TableViewCell: EurekaGooglePlacesTableViewCell {
    
    /// callback that can be used to cuustomize the appearance of the UICollectionViewCell in the inputAccessoryView
    public var customizeTableViewCell: ((TableViewCell) -> Void)?
    
    /// UICollectionView that acts as inputAccessoryView.
    public var tableView: UITableView?

    /// Maximum number of candidates to be shown
    public var numberOfCandidates: Int = 5

    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func setup() {
        super.setup()
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView?.autoresizingMask = .flexibleHeight
        tableView?.isHidden = true
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = UIColor.white
        tableView?.register(TableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    open func showTableView() {
        
        if let controller = formViewController() {
            if tableView?.superview == nil {
                controller.view.addSubview(tableView!)
            }
            let frame = controller.tableView?.convert(self.frame, to: controller.view) ?? self.frame
            tableView?.frame = CGRect(x: 0, y: frame.origin.y + frame.height, width: contentView.frame.width, height: 44 * CGFloat(numberOfCandidates))
            tableView?.isHidden = false
        }
    }
    
    open func hideTableView() {
        tableView?.isHidden = true
    }
    
    override func reload() {
        tableView?.reloadData()
    }
    
    open override func textFieldDidChange(_ textField: UITextField) {
        super.textFieldDidChange(textField)
        if textField.text?.isEmpty == false {
            showTableView()
        }
    }

    open override func textFieldDidEndEditing(_ textField: UITextField) {
        super.textFieldDidEndEditing(textField)
        hideTableView()
    }

    
    //MARK: UITableViewDelegate and Datasource
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predictions?.count ?? 0
    }
    
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! TableViewCell
        if let prediction = predictions?[(indexPath as NSIndexPath).row] {
            cell.setTitle(prediction)
        }
        customizeTableViewCell?(cell)
        return cell
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let prediction = predictions?[(indexPath as NSIndexPath).row] {
            row.value = GooglePlace.prediction(prediction: prediction)
            _ = cellResignFirstResponder()
        }
    }
    
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
