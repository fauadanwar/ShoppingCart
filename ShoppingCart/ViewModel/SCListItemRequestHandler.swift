//
//  SCListItemHandler.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 11/11/21.
//

import Foundation
import Alamofire
import FZImageCache

class SCListItemRequestHandler
{
    func parseResponse(results: [[String:Any]]) -> [SCItem]
    {
        var items = [SCItem]()
        for result in results as [[String:Any]]
        {
            if let thumbnailSrtingArray = result[responseKeys.image_urls_thumbnails.rawValue] as? [String], let url = URL(string: thumbnailSrtingArray.first!), let thumbnailIdArray = result[responseKeys.image_ids.rawValue] as? [String], let image_id = thumbnailIdArray.first
            {
                let imageItem = Item(image: ImageCache.publicCache.placeholderImage, url: url, identifier: image_id)
                
                items.append(SCItem(created_at: result[responseKeys.createdAt.rawValue] as! String, price: result[ responseKeys.price.rawValue] as! String, name: result[responseKeys.name.rawValue] as! String, uid: result[responseKeys.uid.rawValue] as! String, image_ids: result[responseKeys.image_ids.rawValue] as! [String], image_urls: result[responseKeys.image_urls.rawValue] as! [String], image_urls_thumbnails: result[ responseKeys.image_urls_thumbnails.rawValue] as! [String], imageItem: imageItem))
            }
        }
        return items
    }
    
    func fetchListItems(completion: @escaping ([SCItem]?) -> Void)
    {
        AF.request(SCURLs.listItemURL.rawValue).responseJSON { [self] response in
            switch response.result {
            case .success(let JSON):
                print("Success with JSON: \(JSON)")
                guard let responseDictionary = JSON as? [String:Any],
                      let results = responseDictionary[responseKeys.results.rawValue] as? [[String:Any]] else
                {
                    completion(nil)
                    return
                }
                let items = parseResponse(results: results)
                if items.count > 0
                {
                    completion(items)
                } else {
                    completion(nil)
                }
               
            case .failure(let error):
                print("Failure with error: \(error)")
                completion(nil)
            }
        }
    }
}
