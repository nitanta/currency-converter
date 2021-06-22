//
//  CountryTableViewCell.swift
//  currency-converter
//
//  Created by Nitanta Adhikari on 6/18/21.
//

import UIKit

class CountryTableViewCell: UITableViewCell {
    
    static let identifer: String = "CountryTableViewCell"
    
    @IBOutlet weak var countryCodeLbl: UILabel!
    @IBOutlet weak var countryNameLbl: UILabel!
    @IBOutlet weak var emojiLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// Populate tableviewcell
    /// - Parameter data: CountryResponse
    func configure(data: CountryResponse) {
        self.countryCodeLbl.text = data.code
        self.emojiLbl.text = data.emoji
        self.countryNameLbl.text = data.name
    }
    
}
