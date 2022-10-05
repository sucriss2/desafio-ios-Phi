//
//  ColorTests.swift
//  Desafio_SomosphiTests
//
//  Created by Suh on 04/10/22.
//

import XCTest
@testable import Desafio_Somosphi

final class ColorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_uiColor_whenHighlight_thenGetColor() throws {
        let color = Color.highlight
        let expectedColor = UIColor(named: "highlight")
        XCTAssertEqual(expectedColor, color.uiColor)
    }

    func test_uiColor_whenText_thenGetColor() throws {
        let color = Color.text
        let expectedColor = UIColor(named: "text")
        XCTAssertEqual(expectedColor, color.uiColor)
    }

    func test_uiColor_whenAction_thenGetColor() throws {
        let color = Color.action
        let expectedColor = UIColor(named: "action")
        XCTAssertEqual(expectedColor, color.uiColor)
    }

    func test_uiColor_whenDescription_thenGetColor() throws {
        let color = Color.description
        let expectedColor = UIColor(named: "description")
        XCTAssertEqual(expectedColor, color.uiColor)
    }

}
