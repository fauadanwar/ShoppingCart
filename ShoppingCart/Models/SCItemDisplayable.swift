//
//  ItemDisplayable.swift
//  ShoppingCart
//
//  Created by Fauad Anwar on 17/02/22.
//

import Foundation

protocol SCItemDisplayable {
  var titleLabelText: String { get }
  var priceDetail: (title: String, value: String) { get }
  var createdAtDetail: (title: String, value: String) { get }
  var itemImages: [SCItemImage] { get }
}
