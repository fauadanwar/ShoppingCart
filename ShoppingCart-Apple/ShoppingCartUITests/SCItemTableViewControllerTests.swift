//
//  SCItemTableViewControllerTests.swift
//  ShoppingCartUITests
//
//  Created by Fauad Anwar on 11/11/21.
//

import XCTest

class SCItemTableViewControllerTests: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testProgressIndicator() throws {
        let progressIndicator = app.tables["In progress"].activityIndicators["In progress"]
        XCTAssertTrue(progressIndicator.exists)
        waitFor(object: progressIndicator) { !$0.exists }
    }
    
    func testTabelCellAndNavigation() throws
    {
        try testProgressIndicator()
        let navbarTitle = app.navigationBars["Items"].staticTexts["Items"]
        XCTAssertTrue(navbarTitle.exists)
        let tableView = app.tables.containing(.table, identifier: "ItemTableViewController")
        XCTAssertTrue(tableView.cells.count > 0)
        let firstCell = tableView.cells.element(boundBy: 0)
        firstCell.tap()
        
        waitFor(object: navbarTitle) { !$0.exists }

        let notebookNavigationBar = app.navigationBars["Notebook"]
        waitFor(object: notebookNavigationBar) { $0.exists }
    }
    
    func testDetailScreen() throws
    {
        try testTabelCellAndNavigation()
        
        let priceLabel = app.staticTexts["Price:"]
        XCTAssertTrue(priceLabel.exists)

        let createdAtLabel = app.staticTexts["Created at:"]
        XCTAssertTrue(createdAtLabel.exists)

        let datelabel = app.staticTexts["2019-02-24 04:04:17.566515"]
        XCTAssertTrue(datelabel.exists)

        let priceValueLabel = app.staticTexts["AED 5"]
        XCTAssertTrue(priceValueLabel.exists)
               
        let image = app.collectionViews.cells.children(matching: .other).element
        XCTAssertTrue(image.exists)

        let forwardButton = app.buttons["arrow.forward"]
        let arrowBackwardButton = app.buttons["arrow.backward"]

        XCTAssertTrue(forwardButton.exists)
        XCTAssertTrue(forwardButton.isEnabled)

        XCTAssertTrue(arrowBackwardButton.exists)
        XCTAssertFalse(arrowBackwardButton.isEnabled)

        image.swipeLeft()
        XCTAssertTrue(arrowBackwardButton.isEnabled)
        XCTAssertTrue(arrowBackwardButton.isEnabled)
        
        forwardButton.tap()
        XCTAssertFalse(forwardButton.isEnabled)

        arrowBackwardButton.tap()
        XCTAssertTrue(forwardButton.isEnabled)
        
        let notebookNavigationBar = app.navigationBars["Notebook"]
        XCTAssertTrue(notebookNavigationBar.exists)

        notebookNavigationBar.buttons["Items"].tap()
        waitFor(object: notebookNavigationBar) { !$0.exists }
        
        let itemNavigationBar = app.navigationBars["Items"].staticTexts["Items"]
        waitFor(object: itemNavigationBar) { $0.exists }
        XCTAssertTrue(itemNavigationBar.exists)
    }
}

extension XCTestCase {

    // Based on https://stackoverflow.com/a/33855219
    func waitFor<T>(object: T, timeout: TimeInterval = 15, file: String = #file, line: Int = #line, expectationPredicate: @escaping (T) -> Bool) {
        let predicate = NSPredicate { obj, _ in
            expectationPredicate(obj as! T)
        }
        expectation(for: predicate, evaluatedWith: object, handler: nil)

        waitForExpectations(timeout: timeout) { error in
            if (error != nil) {
                let message = "Failed to fulful expectation block for \(object) after \(timeout) seconds."
                let location = XCTSourceCodeLocation(filePath: file, lineNumber: line)
                let issue = XCTIssue(type: .assertionFailure, compactDescription: message, detailedDescription: nil, sourceCodeContext: .init(location: location), associatedError: nil, attachments: [])
                self.record(issue)
            }
        }
    }
}
