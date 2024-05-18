//
//  ItemsTestData.swift
//  ShoppingCartTests
//
//  Created by Fauad Anwar on 21/02/22.
//

import Foundation

@testable import ShoppingCart

struct ItemsTestData {
    static let items: SCItem = {
        let url = Bundle.main.url(forResource: "Items", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return try! decoder.decode(SCItem.self, from: data)
    }()
}
