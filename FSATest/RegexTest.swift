//
//  RegexTest.swift
//  FSA
//
//  Created by Blake Lockley on 8/05/2016.
//  Copyright © 2016 Blake Lockley. All rights reserved.
//

import XCTest
@testable import FSA

class RegexTest: XCTestCase {
  
  //MARK: Basic Components
  func testZeroOne() {
    XCTAssertEqual(Expression.Zero, buildRegex("0"))
    XCTAssertEqual(Expression.One, buildRegex("1"))
  }
  
  func testPair() {
    XCTAssertEqual(Expression.And(.Zero, .One), buildRegex("01"))
    XCTAssertEqual(Expression.Or(.Zero, .One), buildRegex("(0|1)"))
  }
  
  func testSingle() {
    XCTAssertEqual(Expression.Multiple(.Zero), buildRegex("0+"))
    XCTAssertEqual(Expression.Kleene(.Zero), buildRegex("0*"))
  }
  
  //MARK: Simple Strings
  func testSimpleString() {
    XCTAssertEqual(Expression.And(.Zero, .One), buildRegex("01"))
    XCTAssertEqual(Expression.And(.Zero, .And(.One, .Zero)) , buildRegex("010"))
    XCTAssertNotEqual(Expression.And(.And(.Zero, .One), .Zero), buildRegex("010"))
  }
  
  func testOrStrings() {
    XCTAssertEqual(Expression.Or(.Zero, .One), buildRegex("(0|1)"))
    //TODO: More... and tested ors
  }
  
  //MARK: Multiple
  func testMutltipleString() {
    XCTAssertEqual(Expression.Kleene(.Zero), buildRegex("0*"))
    XCTAssertEqual(Expression.Multiple(.Zero), buildRegex("0+"))
  }
  
}
