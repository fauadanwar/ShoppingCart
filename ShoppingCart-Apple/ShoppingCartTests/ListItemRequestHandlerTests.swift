//
//  ListItemRequestHandlerTests.swift
//  ShoppingCartTests
//
//  Created by Fauad Anwar on 11/11/21.
//

import XCTest
@testable import ShoppingCart

class ListItemRequestHandlerTests: XCTestCase {

    var listItemRequestHandler : SCListItemRequestHandler!
    let networkMonitor = NetworkMonitor.shared

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        listItemRequestHandler = SCListItemRequestHandler()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        listItemRequestHandler = nil
    }
    
    func testFetchListItems() throws {
        try XCTSkipUnless(
          networkMonitor.isReachable,
          "Network connectivity needed for this test.")

        
        let promise = expectation(description: "Items are present")
        listItemRequestHandler.fetchListItems(completion: { items, errorMessage in
            XCTAssertNotNil(items, "Items are nil")
            XCTAssertNil(errorMessage, "errorMessage is present \(errorMessage ?? "empty error")")
            promise.fulfill()
        })
        wait(for: [promise], timeout: 10)
    }
    
    func testSCItemsDecodable() throws
    {
        let resultItems = SCItemSection.getSampleData()
        XCTAssertNotNil(resultItems, "Items are nil")
        XCTAssertTrue(resultItems.items.count > 0, "Items are empty")
        
        var item = SCItem.getSampleItemAt(index: 0)
        XCTAssertNotNil(item, "Item is nil")
        item = SCItem.getSampleItemAt(index: 3)
        XCTAssertNil(item, "Item is not nil")

        var image = SCItemImage.getSampleImagesOfItemAt(indexOfItem: 0, indexOfImage: 0)
        XCTAssertNotNil(image, "image is nil")
        image = SCItemImage.getSampleImagesOfItemAt(indexOfItem: 0, indexOfImage: 4)
        XCTAssertNil(image, "image is not nil")
        image = SCItemImage.getSampleImagesOfItemAt(indexOfItem: 3, indexOfImage: 1)
        XCTAssertNil(image, "image is not nil")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
