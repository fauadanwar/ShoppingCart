//
//  SCItem.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 11/11/21.
//

import Foundation
import FZImageCache

enum Section {
    case main
}

@objc class SCItem: NSObject
{
    @objc var created_at: String!
    @objc var price: String!
    @objc var name: String!
    @objc var uid: String!
    @objc var images =  [SCItemImage]()
    @objc var imageItem: Item!
    override var hash : Int {
        var hasher = Hasher()
        hasher.combine(uid)
        return hasher.finalize()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? SCItem else {
            return false
        }
        return uid == other.uid
    }
    
    static func == (lhs: SCItem, rhs: SCItem) -> Bool {
        return lhs.uid == rhs.uid
    }
    
    @objc init(created_at: String, price: String, name: String, uid: String, image_ids: [String], image_urls: [String], image_urls_thumbnails: [String], imageItem: Item)
    {
        self.created_at = created_at
        self.price = price
        self.name = name
        self.uid = uid
        self.imageItem = imageItem
        for index in 0...image_ids.count - 1
        {
            images.append(SCItemImage(image_id: image_ids[index], image_url: image_urls[index], image_urls_thumbnail: image_urls_thumbnails[index]))
        }
        
    }

}
