//
//  PickerTableViewCell.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/17/21.
//

import UIKit

class PickerTableViewCell: UITableViewCell {

    static let identifer: String = "PickerTableViewCell"

    @IBOutlet weak var currencyCodeLbl: UILabel!
    @IBOutlet weak var currencyValueLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Populate table view cell
    /// - Parameters:
    ///   - code: country code
    ///   - value: exchange rate
    func configure(code: String, value: Double) {
        self.currencyCodeLbl.text = code
        self.currencyValueLbl.text = "\(value)"
    }
    
}
