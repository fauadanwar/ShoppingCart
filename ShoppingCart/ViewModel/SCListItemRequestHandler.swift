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
            items.append(SCItem(created_at: result[responseKeys.createdAt.rawValue] as! String, price: result[ responseKeys.price.rawValue] as! String, name: result[responseKeys.name.rawValue] as! String, uid: result[responseKeys.uid.rawValue] as! String, image_ids: result[responseKeys.image_ids.rawValue] as! [String], image_urls: result[responseKeys.image_urls.rawValue] as! [String], image_urls_thumbnails: result[ responseKeys.image_urls_thumbnails.rawValue] as! [String]))
        }
        return items
    }
    
    func fetchListItems(completion: @escaping ([SCItem]?, String?) -> Void)
    {
        AF.request(SCURLs.listItemURL.rawValue).responseJSON { [self] response in
            switch response.result {
            case .success(let JSON):
                print("Success with JSON: \(JSON)")
                guard let responseDictionary = JSON as? [String:Any],
                      let results = responseDictionary[responseKeys.results.rawValue] as? [[String:Any]] else
                {
                    completion(nil, "Failure with parsing")
                    return
                }
                let items = parseResponse(results: results)
                if items.count > 0
                {
                    completion(items, nil)
                } else {
                    completion(nil, "Empty Response")
                }
               
            case .failure(let error):
                print("Failure with error: \(error)")
                completion(nil, error.errorDescription)
            }
        }
    }
}
