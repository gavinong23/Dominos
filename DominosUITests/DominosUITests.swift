//
//  DominosUITests.swift
//  DominosUITests
//
//  Created by OngBoonFong on 26/04/2018.
//  Copyright © 2018 OngBoonFong. All rights reserved.
//

import XCTest

class DominosUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        var app: XCUIApplication!
        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        //app.collectionViews[""].tap()
        
        
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.waitForExistence(timeout: 5)
        
        let collectionViewsQuery = app.collectionViews
        let element = collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element
        element.tap()
        
        let button = app.navigationBars["Pizza Info"].buttons["Back"]
        button.tap()
        
        snapshot("ggwp")
        collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.tap()
        
        app.waitForExistence(timeout: 5)
        button.tap()
        
        let video = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element(boundBy: 1)
        
        XCTAssertTrue(video.waitForExistence(timeout: 15))
        app.waitForExistence(timeout: 2)
        snapshot("ggwp")
        video.tap()
        
        element.tap()
        
        button.tap()
        screenshot()
    
    }
    
    func screenshot(){
        snapshot("gg")
    }
    
}
