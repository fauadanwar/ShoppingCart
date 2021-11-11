//
//  SCListItemHandler.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 11/11/21.
//

import Foundation
import Alamofire
import FZImageCache

class SCListItemHandler
{
    func fetchListItems(completion: @escaping ([SCItem]?) -> Void)
    {
        AF.request(SCURLs.listItemURL.rawValue).responseJSON { response in
            switch response.result {
            case .success(let JSON):
                print("Success with JSON: \(JSON)")
                guard let responseDictionary = JSON as? NSDictionary,
                      let results = responseDictionary.object(forKey: responseKeys.results.rawValue) as? [NSDictionary] else
                {
                    completion(nil)
                    return
                }
                var items = [SCItem]()
                for result in results as [NSDictionary]
                {
                    if let thumbnailSrtingArray = result.object(forKey: responseKeys.image_urls_thumbnails.rawValue) as? [String], let url = URL(string: thumbnailSrtingArray.first!), let thumbnailIdArray = result.object(forKey: responseKeys.image_ids.rawValue) as? [String], let image_id = thumbnailIdArray.first
                    {
                        let imageItem = Item(image: ImageCache.publicCache.placeholderImage, url: url, identifier: image_id)
                        
                        items.append(SCItem(created_at: result.object(forKey: responseKeys.createdAt.rawValue) as! String, price: result.object(forKey: responseKeys.price.rawValue) as! String, name: result.object(forKey: responseKeys.name.rawValue) as! String, uid: result.object(forKey: responseKeys.uid.rawValue) as! String, image_ids: result.object(forKey: responseKeys.image_ids.rawValue) as! [String], image_urls: result.object(forKey: responseKeys.image_urls.rawValue) as! [String], image_urls_thumbnails: result.object(forKey: responseKeys.image_urls_thumbnails.rawValue) as! [String], imageItem: imageItem))
                    }
                }
                completion(items)
            case .failure(let error):
                print("Failure with error: \(error)")
                completion(nil)
            }
        }
    }
}
