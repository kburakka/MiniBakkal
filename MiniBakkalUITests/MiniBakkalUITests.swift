//
//  MiniBakkalUITests.swift
//  MiniBakkalUITests
//
//  Created by Burak KAYA on 2.10.2020.
//  Copyright © 2020 Burak KAYA. All rights reserved.
//

import XCTest

class MiniBakkalUITests: XCTestCase {
    func test_label_when_press_increment_collectionView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        incrementCollectionCell(app: app)
    }
    
    func test_label_when_press_decrement_collectionView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        incrementCollectionCell(app: app)
        decrementCollectionCell(app: app)
    }
    
    func test_label_when_press_increment_table_view() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        incrementCollectionCell(app: app)
        navigateToBasket(app: app)
        incrementTableCell(app: app)
    }
    
    func test_label_when_press_decrement_table_view() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        incrementCollectionCell(app: app)
        navigateToBasket(app: app)
        incrementTableCell(app: app)
        decrementTableCell(app: app)
    }
    
    func test_navigation_to_basket() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        navigateToBasket(app: app)
    }
    
    func test_close_Button() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        incrementCollectionCell(app: app)
        navigateToBasket(app: app)
        closeBasket(app: app)
    }
    
    func test_approve_card() throws {
        let app = XCUIApplication()
        app.launch()
        incrementCollectionCell(app: app)
        navigateToBasket(app: app)
    }
    

    func approveCard(app :XCUIApplication){
        app.buttons["Approve"].tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "AlertView")
    }
    func navigateToBasket(app :XCUIApplication){
        app.buttons["cartBtn"].tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "Sepet")
    }
    func closeBasket(app :XCUIApplication){
        app.buttons["Close"].tap()
        XCTAssertEqual(app.navigationBars.element.identifier, "Mini Bakkal")
    }
    
    func incrementCollectionCell(app :XCUIApplication){
        let button = app.collectionViews["CollectionView"].cells.element(boundBy: 0).buttons["CollectionIncrement"]
        button.tap()
        button.tap()
        let counterLabel = app.collectionViews["CollectionView"].cells.element(boundBy: 0).staticTexts["CollectionLabel"]
        XCTAssertEqual("2", counterLabel.label)
    }
    
    func incrementTableCell(app :XCUIApplication){
        app.tables["TableView"].cells.element(boundBy: 0).buttons["TableIncrement"].tap()
        let counterLabel = app.tables["TableView"].cells.element(boundBy: 0).staticTexts["TableLabel"]
        XCTAssertEqual("3", counterLabel.label)
    }
    func decrementCollectionCell(app :XCUIApplication){
        app.collectionViews["CollectionView"].cells.element(boundBy: 0).buttons["CollectionDecrement"].tap()
        let counterLabel = app.collectionViews["CollectionView"].cells.element(boundBy: 0).staticTexts["CollectionLabel"]
        XCTAssertEqual("1", counterLabel.label)
    }
    
    func decrementTableCell(app :XCUIApplication){
        app.tables["TableView"].cells.element(boundBy: 0).buttons["TableDecrement"].tap()
        let counterLabel = app.tables["TableView"].cells.element(boundBy: 0).staticTexts["TableLabel"]
        XCTAssertEqual("2", counterLabel.label)
    }
}
