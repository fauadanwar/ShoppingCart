//
//  SCItemListCollectionViewCell.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 06/04/22.
//

import UIKit
import FZImageCache

class SCItemListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewItem: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPriceTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    var item: SCItem? {
        didSet {
            imageViewItem.image = ImageCache.publicCache.placeholderImage
            labelName.text = item?.name
            labelPrice.text = item?.price
            labelPriceTitle.text = NSLocalizedString("Price_Title", comment: "Title Text for Price Label")
            
            if let itemImages = item?.images, itemImages.count > 0, let imageItem = itemImages.first, let imageItemURL = imageItem.image_urls_thumbnail
            {
                if let url = URL(string: imageItemURL)
                {
                    ImageCache.publicCache.load(url: url as NSURL, itemIdentifier: imageItem.image_id) { [weak self] imageID, image in
                        if let image_id = imageID as? String, let this = self, image_id == imageItem.image_id
                        {
                            this.imageViewItem.image = image
                        }
                    }
                }
            }
        }
    }
}
