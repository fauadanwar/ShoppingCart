//
//  SCImageCollectionViewCell.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 26/01/22.
//

import UIKit
import FZImageCache

class SCImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewItem:UIImageView!
    
    var imageItem: SCItemImage?
    
    func configureCellWithItem(imageItem: SCItemImage)
    {
        self.imageItem = imageItem;
        self.imageViewItem.image = ImageCache.publicCache.placeholderImage
        if let url = URL(string: imageItem.image_url)
        {
            ImageCache.publicCache.load(url: url as NSURL, itemIdentifier: imageItem.image_id) { [weak self] imageID, image in
                if let image_id = imageID as? String, let this = self, image_id == this.imageItem!.image_id
                {
                    this.imageViewItem.image = image
                }
            }
        }
    }
}
