//
//  SCItem.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 11/11/21.
//

import Foundation
import FZImageCache

@objc class SCItem: NSObject, Decodable
{
    @objc var created_at: String!
    @objc var price: String!
    @objc var name: String!
    @objc var uid: String!
    @objc var image_ids =  [String]()
    @objc var image_urls =  [String]()
    @objc var image_urls_thumbnails =  [String]()

    @objc var images =  [SCItemImage]()
    
    enum CodingKeys: String, CodingKey
    {
        case created_at = "created_at"
        case price, name, uid, image_ids, image_urls, image_urls_thumbnails
    }
    
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        created_at = try values.decode(String.self, forKey: .created_at)
        price = try values.decode(String.self, forKey: .price)
        name = try values.decode(String.self, forKey: .name)
        uid = try values.decode(String.self, forKey: .uid)
        image_ids = try values.decode([String].self, forKey: .image_ids)
        image_urls = try values.decode([String].self, forKey: .image_urls)
        image_urls_thumbnails = try values.decode([String].self, forKey: .image_urls_thumbnails)
        for index in 0...image_ids.count - 1
        {
            images.append(SCItemImage(image_id: image_ids[index], image_url: image_urls[index], image_urls_thumbnail: image_urls_thumbnails[index]))
            //Duplicating images as there is only one image coming in response
            images.append(SCItemImage(image_id: image_ids[index] + "Extra 1", image_url: image_urls[index], image_urls_thumbnail: image_urls_thumbnails[index]))
            images.append(SCItemImage(image_id: image_ids[index] + "Extra 2", image_url: image_urls[index], image_urls_thumbnail: image_urls_thumbnails[index]))
        }
    }
    
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
}

extension SCItem
{
    static func getSampleItemAt(index: Int) -> SCItem?
    {
        let resultItems = SCItemSection.getSampleData()
        guard resultItems.items.count > index else {
            return nil
        }
        return resultItems.items[index]
    }
}
