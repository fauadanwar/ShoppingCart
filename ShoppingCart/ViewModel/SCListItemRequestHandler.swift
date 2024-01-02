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
    func fetchListItems(completion: @escaping ([SCItemSection]?, String?) -> Void)
    {
        AF.request(SCURLs.listItemURL.rawValue)
            .validate()
            .responseDecodable(of: SCItemSection.self) { (response) in
                guard let results = response.value else
                {
                    completion(nil, "Failure with API")
                    return
                }
                completion([results], nil)
            }
    }
}
