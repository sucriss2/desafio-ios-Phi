//
//  StatementModelTests.swift
//  Desafio_SomosphiTests
//
//  Created by Suh on 07/10/22.
// swiftlint:disable line_length

import XCTest
@testable import Desafio_Somosphi

final class StatementModelTests: XCTestCase {

    var sut: StatementModel!
    var mockedService: StatementServiceMock!
    var viewControllerSpy: StatementVCSpy!
    var userDefaultsMock: UserDefaultsMock!
    var amountServiceMock: AmountServiceMock!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
        mockedService = nil
        viewControllerSpy = nil
        userDefaultsMock = nil
    }

    func test_changeAmountVisibility_shouldChangeIsAmountVisible () throws {
        userDefaultsMock = UserDefaultsMock()
        sut = StatementModel(userDefaults: userDefaultsMock)

        sut?.changeAmountVisibility()
        XCTAssertTrue(userDefaultsMock.value!)
        XCTAssertTrue(sut.isAmountVisible)

        sut?.changeAmountVisibility()
        XCTAssertFalse(userDefaultsMock.value!)
        XCTAssertFalse(sut.isAmountVisible)

    }

    func test_changeAmountVisibiliby_shouldDelegate() throws {
        sut = StatementModel()
        viewControllerSpy = StatementVCSpy()
        sut.delegate = viewControllerSpy
        sut.changeAmountVisibility()

        XCTAssertEqual(viewControllerSpy.didUpdateBalanceCount, 1)
    }

    func test_formattedAmount_returnString() throws {
        userDefaultsMock = UserDefaultsMock()
        sut = StatementModel(userDefaults: userDefaultsMock)

        sut.changeAmountVisibility()
        XCTAssertEqual(sut.formattedAmount, "R$ 0,00")

        sut.changeAmountVisibility()
        XCTAssertEqual(sut.formattedAmount, "––––––")
    }

    func test_canShowLoading_returnHasMorePage() throws {
        userDefaultsMock = UserDefaultsMock()
        sut = StatementModel(userDefaults: userDefaultsMock)

        XCTAssertTrue(sut.canShowLoading)
    }

    func test_fetchStatement_whenHasMorePages_returnTrue() throws {
        userDefaultsMock = UserDefaultsMock()
        sut = StatementModel(userDefaults: userDefaultsMock)
        mockedService = StatementServiceMock(statements: Statements(items: [.fixture()]), page: 1, error: nil)
        sut.serviceStatement = mockedService

        sut.fetchStatement()

        XCTAssertFalse(sut.statements.isEmpty)

        mockedService.getEmptyStatements()
        mockedService.statements!.items = []

        print("===== \(mockedService.statements!.items) =====")
        sut.fetchStatement()
        XCTAssertTrue(mockedService.statements!.items.isEmpty)

    }

}

class StatementServiceMock: StatementService {
    private(set) var fetchStatementCount: Int = 0
    let page: Int
    var statements: Statements?
    let error: Error?

    init(statements: Statements?, page: Int, error: Error?) {
        self.statements = statements
        self.page = page
        self.error = error
    }

    override func fetchStatements(
        page: Int,
        size: Int = 10,
        onComplete: @escaping (Statements) -> Void,
        onError: @escaping (Error) -> Void
    ) {
        fetchStatementCount += 1
        if let statement = statements {
            onComplete(statement)
        } else if let error = error {
            onError(error)
        }
        print("=====>> PASSOU AQUI")

    }

    func getEmptyStatements() {
        statements = Statements(items: [])
    }

}

class StatementVCSpy: StatementModelDelegate {
    var model: StatementModel!
    var message: String?
    var didUpdateBalanceCount: Int = 0
    private(set) var statements: [Statement] = []

    func didUpdateStatement() {
        print("++++sucessoooo")
    }

    func didUpdateBalance() {
        didUpdateBalanceCount += 1
        print("==== BALANCE ====")
    }

    func didErrorRepositories(message: String) {
        self.message = message
    }

}

class AmountServiceMock: AmountService {

    private(set) var fetchStatementCount: Int = 0
    let error: Error?
    let amount: Amount?

    init(amount: Amount, error: Error) {
        self.amount = amount
        self.error = error
    }

    override func fecthAmount(
        onComplete: @escaping (Amount) -> Void,
        onError: @escaping (Error) -> Void
    ) {

        fetchStatementCount += 1
        if let error = error {
            onError(error)
        } else if let amount = amount {
            onComplete(amount)
        }
    }

}

class UserDefaultsMock: UserDefaults {
    var value: Bool?
    var setterKey: String = ""
    var getterKey: String = ""

    override func setValue(_ value: Any?, forKey key: String) {
        self.value = value as? Bool
        self.setterKey = key
    }

    override func bool(forKey defaultName: String) -> Bool {
        self.getterKey = defaultName
        guard let value = self.value else {
            return false
        }
        return value

    }

}

enum TestGenericError2: Error {
    case generic
}
