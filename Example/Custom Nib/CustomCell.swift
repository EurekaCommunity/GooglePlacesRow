//
//  CustomCell.swift
//  Example
//
//  Created by Mathias Claassen on 5/18/18.
//

import Eureka
import GooglePlacesRow

class CustomCell: GooglePlacesCollectionCell<GPCollectionViewCell> {

    @IBOutlet public weak var myImageView: UIImageView!

    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setup() {
        super.setup()
        height = { UITableView.automaticDimension }
    }

    override func update() {
        super.update()
        textLabel?.text = nil
        titleLabel?.text = row.title
    }

}

final class CustomRow: _GooglePlacesRow<CustomCell>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
        cellProvider = CellProvider<CustomCell>(nibName: "CustomCell")
    }
}
