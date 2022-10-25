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

    override func setUpWithError() throws {
        let storyboard = UIStoryboard.init(name: "StatementStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: "StatementViewController") as? StatementViewController else {
            fatalError()
        }
        sut = viewController

    }

    override func tearDownWithError() throws {
        sut = nil
        mockedModel = nil
    }

    func test_viewDidLoad_shouldCallModel() throws {
        mockedModel = StatementModelMock(error: nil, amount: Amount(amount: 230))
        sut.model = mockedModel

        _ = sut.view

        XCTAssertEqual(sut.title, "Extrato")
    }

    func test_didUpBalance_returnSucces() throws {
        mockedModel = StatementModelMock(
            error: nil,
            amount: Amount(amount: 1234))
        sut.model = mockedModel

        _ = sut.view

        sut.didUpdateBalance()

        XCTAssertEqual(mockedModel!.amount!.amount, 1234)
    }

    func test_didUpBalance_returnError() throws {
        mockedModel = StatementModelMock(
            error: TestGenericError2.generic,
            amount: nil)
        sut.model = mockedModel
        mockedModel.delegate = sut

        _ = sut.view

        XCTAssertEqual(mockedModel.loadStatementCount, 1)
    }

//    func test_didErrorRepositories_returnError() throws {
//        mockedModel = StatementModelMock(error: nil, amount: nil)
//        sut.model = mockedModel
//        _ = sut.view
//        
//    }

}

class StatementModelMock: StatementModel {
    private(set) var loadStatementCount: Int = 0
    var error: Error?
    var page: Int = 0
    var amount: Amount?
    var mockServiceStatement: StatementService?
    var mockServiceAmount: AmountService?
    private(set) var mockedStatements: [Statement]

    init(error: Error?, amount: Amount?) {
        self.error = error
        self.amount = amount
        mockedStatements = []
    }

    override func fetchStatement() {
        loadStatementCount += 1
        print("---> PASSOUUUUUUUU AQUIIIII")

        mockServiceAmount?.fecthAmount(
            onComplete: { result in
                self.amount = result
                self.delegate?.didUpdateBalance()
                print("==>> s u c e s s ==")
            }, onError: { error in
                print(error.localizedDescription)
                print(" >>>>E R R O R<<<<")
            })

        mockServiceStatement?.fetchStatements(
            page: page,
            onComplete: { statements in
                self.mockedStatements.append(contentsOf: statements.items)
                self.delegate?.didUpdateStatement()
                print("sucess statement")
            }, onError: { error in
                self.delegate?.didErrorRepositories(message: "error" )
                print(error.localizedDescription)
                print("error service statement")
            })
    }

}
