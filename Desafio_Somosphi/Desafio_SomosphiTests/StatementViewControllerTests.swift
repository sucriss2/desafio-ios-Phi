//
//  StatementViewControllerTests.swift
//  Desafio_SomosphiTests
//
//  Created by Suh on 19/10/22.
//

import XCTest
@testable import Desafio_Somosphi

final class StatementViewControllerTests: XCTestCase {

    var sut: StatementViewController!
    var mockedModel: StatementModelMock!
    var mockedServiceAmount: AmountServiceMock!
    var mockedServiceStatement: StatementServiceMock!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard.init(name: "StatementStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: "StatementViewController") as? StatementViewController else {
            fatalError()
        }
        sut = viewController

    }

    override func tearDownWithError() throws {

    }

    func test_viewDidLoad_shouldCallModel() throws {
        mockedModel = StatementModelMock()
        mockedServiceAmount = AmountServiceMock(amount: Amount(amount: 12), error: nil)
        sut.model = mockedModel

        _ = sut.view

        XCTAssertEqual(sut.title, "Extrato")
    }

//    func test_didUpBalance_returnSucces() throws {
//        mockedModel = StatementModelMock()
//        mockedServiceAmount = AmountServiceMock(amount: Amount(amount: 12), error: nil)
//        mockedServiceStatement = StatementServiceMock(
//            statements: .init(items:[.fixture(), .fixture()]),
//            page: 1,
//            error: nil
//        )
//
//        mockedModel.serviceAmount = mockedServiceAmount
//        mockedModel.serviceStatement = mockedServiceStatement
//
//        sut.model = mockedModel
//
//        _ = sut.view
//
//
//        XCTAssertEqual(sut.balanceLabel.text, "1234")
//
//    }
//
    func test_didUpStatement_returnSucces() throws {
        mockedModel = StatementModelMock()
        mockedServiceAmount = AmountServiceMock(amount: nil, error: nil)
        mockedServiceStatement = StatementServiceMock(
            statements: .init(items: [.fixture(), .fixture()]), page: 1, error: nil)

        mockedModel.serviceAmount = mockedServiceAmount
        mockedModel.serviceStatement = mockedServiceStatement
        sut.model = mockedModel
        mockedModel.delegate = sut

        _ = sut.view

        mockedModel.fetchStatement()

        XCTAssertEqual(mockedModel.loadStatementCount, 2)
    }

    func test_didErrorRepositories_returnError() throws {
        mockedModel = StatementModelMock()
        mockedServiceAmount = AmountServiceMock(amount: nil, error: nil)
        mockedServiceStatement = StatementServiceMock(
            statements: nil, page: 1, error: TestGenericError.generic)

        mockedModel.serviceAmount = mockedServiceAmount
        mockedModel.serviceStatement = mockedServiceStatement
        sut.model = mockedModel
        mockedModel.delegate = sut

        _ = sut.view

        XCTAssertEqual(mockedModel.loadStatementCount, 1)
    }

    func test_didUpdateBalance_returnSucces() throws {
        mockedModel = StatementModelMock()
        mockedServiceAmount = AmountServiceMock(amount: Amount(amount: 12), error: nil)
        mockedServiceStatement = StatementServiceMock(
            statements: nil, page: 1, error: TestGenericError.generic)

        mockedModel.serviceAmount = mockedServiceAmount
        mockedModel.serviceStatement = mockedServiceStatement
        sut.model = mockedModel
        mockedModel.delegate = sut

        _ = sut.view

        XCTAssertEqual(mockedModel.loadStatementCount, 1)
    }

}

class StatementModelMock: StatementModel {
    private(set) var loadStatementCount: Int = 0

    override func fetchStatement() {
        loadStatementCount += 1
        super.fetchStatement()
    }

}
