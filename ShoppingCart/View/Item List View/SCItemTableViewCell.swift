//
//  SCItemsTableViewCell.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 11/11/21.
//

import UIKit
import FZImageCache

class SCItemTableViewCell: UITableViewCell {
    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPriceTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    var item: SCItem?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code =
        labelPriceTitle.text = NSLocalizedString("Price_Title", comment: "Title Text for Price Label")
    }
    
    func configureCell(item: SCItem)
    {
        self.item = item
        labelName.text = item.name
        labelPrice.text = item.price
        imageViewItem.image = ImageCache.publicCache.placeholderImage
        if let imageItem = item.images.first, let url = NSURL(string: imageItem.image_urls_thumbnail)
        {
            ImageCache.publicCache.load(url: url, itemIdentifier: item) { [unowned self] (item, image) in
                if let img = image, self.item == item as? SCItem
                {
                    self.imageViewItem.image = img
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
