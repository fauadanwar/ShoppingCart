//
//  SCListItemHandler.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 11/11/21.
//

import Foundation
import Alamofire

class SCListItemHandler
{
    func fetchListItems(completion: @escaping ([SCItem]?) -> Void)
    {
        AF.request(SCURLs.listItemURL.rawValue).responseJSON { response in
            switch response.result {
            case .success(let JSON):
                print("Success with JSON: \(JSON)")
                guard let responseDictionary = JSON as? NSDictionary,
                      let results = responseDictionary.object(forKey: responseKeys.results) as? [NSDictionary] else
                {
                    completion(nil)
                    return
                }
                var items = [SCItem]()
                for result in results as [NSDictionary]
                {
                    items.append(SCItem(created_at: result.object(forKey: responseKeys.createdAt) as! String, price: result.object(forKey: responseKeys.price) as! String, name: result.object(forKey: responseKeys.name) as! String, uid: result.object(forKey: responseKeys.uid) as! String, image_ids: result.object(forKey: responseKeys.image_ids) as! [String], image_urls: result.object(forKey: responseKeys.image_urls) as! [String], image_urls_thumbnails: result.object(forKey: responseKeys.image_urls_thumbnails) as! [String]))
                }
                completion(items)
            case .failure(let error):
                print("Failure with error: \(error)")
                completion(nil)
            }
        }
    }
}
