//
//  Constants.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 11/11/21.
//

import Foundation

enum SCURLs : String {
    case listItemURL = "https://ey3f2y0nre.execute-api.us-east-1.amazonaws.com/default/dynamodb-writer"
}

enum responseKeys : String {
    case results = "results"
    case createdAt = "created_at"
    case price = "price"
    case name = "name"
    case uid = "uid"
    case image_ids = "image_ids"
    case image_urls = "image_urls"
    case image_urls_thumbnails = "image_urls_thumbnails"
}
