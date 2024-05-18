//
//  SCItemImage.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 11/11/21.
//

import Foundation
@objc class SCItemImage: NSObject
{
    @objc var image_id :  String!
    @objc var image_url :  String!
    @objc var image_urls_thumbnail :  String!

    override var hash : Int {
        var hasher = Hasher()
        hasher.combine(image_id)
        return hasher.finalize()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? SCItemImage else {
            return false
        }
        return image_id == other.image_id
    }
    
    static func == (lhs: SCItemImage, rhs: SCItemImage) -> Bool {
        return lhs.image_id == rhs.image_id
    }
    
    @objc init(image_id: String, image_url: String, image_urls_thumbnail: String) {
        self.image_id = image_id
        self.image_url = image_url
        self.image_urls_thumbnail = image_urls_thumbnail
    }

}

extension SCItemImage
{
    static func getSampleImagesOfItemAt(indexOfItem: Int, indexOfImage: Int) -> SCItemImage?
    {
        guard let item = SCItem.getSampleItemAt(index: indexOfItem) else
        {
            return nil
        }

        guard item.images.count > indexOfImage else {
            return nil
        }
        
        return item.images[indexOfItem]
    }
}
