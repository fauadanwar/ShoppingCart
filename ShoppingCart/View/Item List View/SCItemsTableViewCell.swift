//
//  SCItemsTableViewCell.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 11/11/21.
//

import UIKit

class SCItemsTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPriceTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code =
        labelPriceTitle.text = NSLocalizedString("Price_Title", comment: "Title Text for Price Label")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
