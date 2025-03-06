//
//  AssetoneDemoTests.swift
//  AssetoneDemoTests
//
//  Created by DEVM-SUNDAR on 06/03/25.
//

import XCTest
@testable import AssetoneDemo

final class AssetoneDemoTests: XCTestCase {

    var viewController: ViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
               let storyboard = UIStoryboard(name: "Main", bundle: nil)
               viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController
               viewController.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewController = nil
                try super.tearDownWithError()
    }
    // Test ViewController is not nil
       func testViewControllerInitialization() {
           XCTAssertNotNil(viewController, "ViewController should be initialized")
       }

       // Test TableView Delegate & DataSource
       func testTableViewDelegatesAssigned() {
           XCTAssertNotNil(viewController.newsPostTable.delegate, "TableView delegate should be assigned")
           XCTAssertNotNil(viewController.newsPostTable.dataSource, "TableView dataSource should be assigned")
       }

       // Test Number of Rows in TableView (Initially should be 0)
       func testNumberOfRowsInTableView() {
           let rows = viewController.tableView(viewController.newsPostTable, numberOfRowsInSection: 0)
           XCTAssertEqual(rows, 0, "Initially, rows should be 0 before fetching data")
       }

       // Test Alert Presentation on Error Handling
       func testErrorHandlingShowsAlert() {
           let mockController = UIViewController()
           let expectation = expectation(description: "Alert should be presented")

           DispatchQueue.main.async {
               PreferenceManager.shared.errorHandling(errorMessage: "Test Error", currentController: mockController) {
                   expectation.fulfill()
               }
           }

           wait(for: [expectation], timeout: 3.0)
           XCTAssertNotNil(mockController.presentedViewController as? UIAlertController, "Alert should be presented")
       }
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
