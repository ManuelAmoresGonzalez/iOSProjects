//
//  CalculatorTest.swift
//  AllAboutUTsTests
//
//  Created by Manuel Enrique Amores Gonzalez on 29/1/26.
//
import XCTest
@testable import AllAboutUTs


final class CalculatorTest: XCTestCase {
    
    var sut: Calculator!
    
    func testCalculatorNil(){
        XCTAssertNil(sut)
    }
    
    func testCalculatorNotNil() {
        sut = Calculator()
        XCTAssertNotNil(sut)
    }
}
