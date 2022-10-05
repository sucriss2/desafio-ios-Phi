//
//  StatementTests.swift
//  Desafio_SomosphiTests
//
//  Created by Suh on 04/10/22.
//

import XCTest
@testable import Desafio_Somosphi

final class StatementTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_isTypePix_whenPixCastOut_returnsTrue() throws {
        let tType = "PIXCASHOUT"
        let statement = Statement.fixture(tType: tType)
        XCTAssertTrue(statement.isTypePix)
    }

    func test_isTypePix_whenPixCastIn_returnsTrue() throws {
        let tType = "PIXCASHIN"
        let statement = Statement.fixture(tType: tType)
        XCTAssertTrue(statement.isTypePix)
    }

    func test_isTypePix_whenNotPix_returnsFalse() throws {
        let tType = "TRANSFEROUT"
        let statement = Statement.fixture(tType: tType)
        XCTAssertFalse(statement.isTypePix)
    }

    func test_destinationName_whenTargetNotNil_returnsTarget() throws {
        let target = "name"
        let statement = Statement.fixture(target: target)
        XCTAssertEqual(statement.destinationName, target)
    }

    func test_destinationName_whenTargetNil_whenFromNotNil_returnsFrom() throws {
        let from = "name"
        let statement = Statement.fixture(target: nil, from: from)
        XCTAssertEqual(statement.destinationName, from)
    }

    func test_destinationName_whenNil_returnsEmpty() throws {
        let destination = ""
        let statement = Statement.fixture(target: nil, from: nil)
        XCTAssertEqual(statement.destinationName, destination)
    }

    func test_typeTarget_whenTargetNotNil_returnsString() throws {
        let string = "target"
        let type = Statement.fixture(target: string, from: nil)
        XCTAssertEqual(type.typeTarget, "Destinatario")
    }

    func test_typeTarget_whenFromNotNil_returnsString() throws {
        let string = "from"
        let type = Statement.fixture(target: nil, from: string)
        XCTAssertEqual(type.typeTarget, "Emissor")
    }

    func test_typeTarget_whenFromNotNil_whenTargetNotNil_returnsEmpty() throws {
        let string = "nem from nem target"
        let type = Statement.fixture(target: nil, from: nil)
        XCTAssertEqual(type.typeTarget, "")
    }

}
