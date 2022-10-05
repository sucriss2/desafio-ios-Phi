//
//  FormatterTests.swift
//  Desafio_SomosphiTests
//
//  Created by Suh on 04/10/22.
//

import XCTest
@testable import Desafio_Somosphi

final class FormatterTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_formatCurrency() throws {
        XCTAssertEqual("R$ 23,00", Formatter.formatCurrency(value: 23))
        XCTAssertEqual("R$ 4,00", Formatter.formatCurrency(value: 4))
        XCTAssertEqual("R$ 51,00", Formatter.formatCurrency(value: 51))
        XCTAssertEqual("R$ 30,00", Formatter.formatCurrency(value: 30))
        XCTAssertEqual("R$ 220,00", Formatter.formatCurrency(value: 220))
    }

    func test_getDate() throws {
        let expectedDate = Date(timeIntervalSince1970: 0)
        let date = Formatter.getDate(from: "01/01/1970", using: "dd/MM/yyyy")
        XCTAssertEqual(expectedDate, date)

        let expectedDate2 = Date(timeIntervalSince1970: 86400)
        let date2 = Formatter.getDate(from: "02/01/1970", using: "dd/MM/yyyy")
        XCTAssertEqual(expectedDate2, date2)
    }

    func test_getDateString() throws {
        let date = Date(timeIntervalSince1970: 0)
        let dateString = Formatter.getDateString(from: date, using: "dd/MM")
        XCTAssertEqual("01/01", dateString)

        let dateString2 = Formatter.getDateString(from: date, using: "yyyy-MM-dd'T'HH:mm:ss'Z'")
        XCTAssertEqual("1970-01-01T00:00:00Z", dateString2)
    }

    func test_getDateString_whenValueNil_returnsEmptyString() {
        let value = Formatter.getDateString(from: nil, using: "dd/MM")
        XCTAssertTrue(value.isEmpty)
    }

    func test_formatDate_whenMaskLong_whenFormatShort_thenGetFormattedString() throws {
        let dateString = "2022-10-04T00:00:00Z"
        let date = Formatter.formatDate(string: dateString)
        XCTAssertEqual("04/10", date)
    }

    func test_formatDate_whenMaskLong_whenFormatLongBrDateTime_thenGetFormattedString() throws {
        let dateString = "2022-10-04T00:00:00Z"
        let date = Formatter.formatDate(string: dateString, from: .long, to: .longBrDateTime)
        XCTAssertEqual("10/04/2022 - 00:00:00", date)
    }

    func test_formatDate_whenMaskShort_whenFormatLong_thenGetFormattedString() throws {
        let dateString = "04/10"
        let date = Formatter.formatDate(string: dateString, from: .short, to: .long)
        XCTAssertEqual("2000-10-04T00:00:00Z", date)
    }

    func test_formatDate_whenMaskShort_whenFormatLongBrDateTime_thenGetFormattedString() throws {
        let dateString = "04/10"
        let date = Formatter.formatDate(string: dateString, from: .short, to: .longBrDateTime)
        XCTAssertEqual("10/04/2000 - 00:00:00", date)
    }

    func test_formatDate_whenFormatLongBrDateTime_whenMaskShort_thenGetFormattedString() throws {
        let dateString = "10/04/2022 - 00:00:00"
        let date = Formatter.formatDate(string: dateString, from: .longBrDateTime, to: .short)
        XCTAssertEqual("04/10", date)
    }

    func test_formatDate_whenFormatLongBrDateTime_whenMaskLong_thenGetFormattedString() throws {
        let dateString = "10/04/2022 - 00:00:00"
        let date = Formatter.formatDate(string: dateString, from: .longBrDateTime, to: .long)
        XCTAssertEqual("2022-10-04T00:00:00Z", date)
    }

}
