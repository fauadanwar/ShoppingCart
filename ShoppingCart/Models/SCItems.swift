//
//  SCItems.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 17/02/22.
//

import Foundation

struct SCItems: Decodable
{
  let items: [SCItem]
  
  enum CodingKeys: String, CodingKey {
    case items = "results"
  }
}
