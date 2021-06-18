//
//  PickerTableViewCell.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/17/21.
//

import UIKit

class PickerTableViewCell: UITableViewCell {

    static let identifer: String = "PickerTableViewCell"

    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var currencyCodeLbl: UILabel!
    @IBOutlet weak var currencyValueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure() {
    }
    
}
