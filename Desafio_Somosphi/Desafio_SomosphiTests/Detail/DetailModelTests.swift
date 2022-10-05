//
//  DetailModelTests.swift
//  Desafio_SomosphiTests
//
//  Created by Suh on 05/10/22.
//

import XCTest
@testable import Desafio_Somosphi

final class DetailModelTests: XCTestCase {

    var sut: DetailModel?
    var mockedService: DetailServiceMock?
    var viewControllerSpy: DetailViewControllerSpy?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_loadDetail_whenSucess_returnsStatement() throws {
        setUpModel(isError: false)

        sut?.loadDetail()

        guard let statement = viewControllerSpy?.statement else {
            XCTFail("Statement not found")
            return
        }

        XCTAssertEqual(statement.amount, 1807)
        XCTAssertEqual(statement.statementID, "E79E0C9A-46AE-4DBA-82F5-D0BACC53F6CF")
        XCTAssertEqual(statement.target, "David Bond")
        XCTAssertEqual(statement.description, "Transferência realizada")
        XCTAssertEqual(statement.authentication, "")
        XCTAssertEqual(statement.tType, "TRANSFEROUT")
        XCTAssertNil(statement.from)
    }

    func test_loadDetail_whenError_returnsError() throws {
        setUpModel(isError: true)

        sut?.loadDetail()

        XCTAssertEqual(
            viewControllerSpy?.message,
            "The operation couldn’t be completed. (Desafio_SomosphiTests.TestGenericError error 0.)"
        )
    }

    // MARK: Helpers

    func setUpModel(isError: Bool) {
        viewControllerSpy = DetailViewControllerSpy()

        if isError {
            mockedService = DetailServiceMock(statement: nil, error: TestGenericError.generic)
        } else {
            mockedService = DetailServiceMock(statement: .fixture(), error: nil)
        }

        sut = DetailModel(statementID: "")

        sut?.service = mockedService
        sut?.delegate = viewControllerSpy
        viewControllerSpy?.model = sut
    }

}

class DetailServiceMock: DetailService {
    let statement: Statement?
    let error: Error?

    init(statement: Statement?, error: Error?) {
        self.statement = statement
        self.error = error
    }

    override func fetchDetail(
        id: String,
        onComplete: @escaping (Statement) -> Void,
        onError: @escaping (Error) -> Void
    ) {

        if let statement = statement {
            onComplete(statement)
            print(" =====>>> SUCESSOOO <<<===== ")
        } else if let error = error {
            print("++++ ERROOOO +++++++ ")
            onError(error)
        }

    }
}

class DetailViewControllerSpy: DetailModelDelegate {
    var model: DetailModel?
    var message: String?
    private(set) var statement: Statement?

    func didUpShowDetail() {
        statement = model?.statement
    }

    func didShowError(message: String) {
        self.message = message
    }
}

enum TestGenericError: Error {
    case generic
}
