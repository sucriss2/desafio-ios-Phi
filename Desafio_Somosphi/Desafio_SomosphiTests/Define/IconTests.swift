//
//  IconTests.swift
//  Desafio_SomosphiTests
//
//  Created by Suh on 04/10/22.
//

import XCTest
@testable import Desafio_Somosphi

final class IconTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_icon_whenUiImageEye_thenGetImage() throws {
        let image = Icon.eye
        let expectedIcon = UIImage(systemName: "eye.fill")
        XCTAssertEqual(expectedIcon, image.sfIcon)
    }

    func test_icon_whenUiImageEyeSlash_thenGetImage() throws {
        let image = Icon.eyeSlash
        let expectedIcon = UIImage(systemName: "eye.slash.fill")
        XCTAssertEqual(expectedIcon, image.sfIcon)
    }

}
