//
//  CryptoTableViewCell.swift
//  CryptoFishing
//
//  Created by Berat Rıdvan Asiltürk on 4.09.2023.
//

import UIKit

class CryptoTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // Guncel currency ve price'i cekmek icin kullandik.
    public var item: Crypto! {
        didSet{
            self.nameLabel.text = item.currency
            self.priceLabel.text = item.price
        }
    }

}
