//
//  DetailViewControllerTests.swift
//  Desafio_SomosphiTests
//
//  Created by Suh on 05/10/22.
//

import XCTest
@testable import Desafio_Somosphi

final class DetailViewControllerTests: XCTestCase {

    var sut: DetailViewController!
    var mockedModel: DetailModelMock?

    override func setUpWithError() throws {
        let storyboard = UIStoryboard.init(name: "DetailStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(
            withIdentifier: "DetailViewController") as? DetailViewController else {
            fatalError()
        }
        sut = viewController
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_viewDidLoad_shouldCallModel() throws {
        mockedModel = DetailModelMock(statement: nil, error: TestGenericError.generic)
        sut?.model = mockedModel

        _ = sut?.view

        XCTAssertEqual(mockedModel?.loadDetailCount, 1)

        XCTAssertTrue(sut.descriptionLabel.text!.isEmpty)
        XCTAssertTrue(sut.targetLabel.text!.isEmpty)
        XCTAssertTrue(sut.bankLabel.text!.isEmpty)
        XCTAssertTrue(sut.authenticationLabel.text!.isEmpty)
        XCTAssertTrue(sut.valueLabel.text!.isEmpty)
        XCTAssertTrue(sut.dateHourLabel.text!.isEmpty)
    }

    func test_erase_shouldCleanFields() throws {
        mockedModel = DetailModelMock(statement: .fixture(), error: nil)
        sut.model = mockedModel
        _ = sut.view

        sut.descriptionLabel.text = "SuelenCristina"
        sut.targetLabel.text = "destinatario"
        sut.bankLabel.text = "Bank Phil"
        sut.authenticationLabel.text = "0987-97870-8684"
        sut.valueLabel.text = "1807"
        sut.dateHourLabel.text = "04-10-2022"

        XCTAssertFalse(sut.descriptionLabel.text!.isEmpty)
        XCTAssertFalse(sut.targetLabel.text!.isEmpty)
        XCTAssertFalse(sut.bankLabel.text!.isEmpty)
        XCTAssertFalse(sut.authenticationLabel.text!.isEmpty)
        XCTAssertFalse(sut.valueLabel.text!.isEmpty)
        XCTAssertFalse(sut.dateHourLabel.text!.isEmpty)

        sut.erase()

        XCTAssertTrue(sut.descriptionLabel.text!.isEmpty)
        XCTAssertEqual(sut.targetLabel.text, "")
        XCTAssertEqual(sut.bankLabel.text, "")
        XCTAssertEqual(sut.authenticationLabel.text, "")
        XCTAssertEqual(sut.valueLabel.text, "")
        XCTAssertEqual(sut.dateHourLabel.text, "")
    }

    func test_takeDetailStatement_returnImage() throws {
        _ = sut.view
        let image = sut.takeDetailStatement()

        XCTAssertNotNil(image)
    }

//    func test_didUpShowDetail() throws {
//
//    }

}

class DetailModelMock: DetailModel {
    private(set) var loadDetailCount = 0
    let mockedStatement: Statement?
    let error: Error?

    override var statement: Statement? {
        return mockedStatement
    }

    init(statement: Statement?, error: Error?) {
        self.mockedStatement = statement
        self.error = error
        super.init(statementID: "")
    }

    override func loadDetail() {
        loadDetailCount += 1
        if mockedStatement != nil {
            self.delegate?.didUpShowDetail()
        } else if error != nil {
            self.delegate?.didShowError(message: "Errooo")
        }

    }
}
