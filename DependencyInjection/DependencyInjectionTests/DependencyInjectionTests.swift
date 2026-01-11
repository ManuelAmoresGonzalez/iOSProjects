//
//  DependencyInjectionTests.swift
//  DependencyInjectionTests
//
//  Created by Manuel Enrique Amores Gonzalez on 16/5/25.
//

import XCTest
@testable import DependencyInjection

final class DependencyInjectionTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let productManager = MockProductManager()
        let viewModel = ViewModel(manager: productManager)
        XCTAssertEqual(viewModel.numberOfProducts(), 3)
    }

}
