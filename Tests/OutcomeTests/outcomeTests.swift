//
//  outcomeTests.swift
//
//  Created by Guillaume Lessard on 6/5/18.
//  Copyright © 2018 Guillaume Lessard. All rights reserved.
//

import XCTest

import Outcome

class OutcomeTests: XCTestCase
{
  func testGetters() throws
  {
    let v1 = nzRandom()
    let v2 = nzRandom()

    let detValue = Outcome<Int>(value: v1)
    let detError = Outcome<Int>(error: TestError(v2))

    do {
      let v = try detValue.get()
      XCTAssert(v1 == v)

      let _ = try detError.get()
    }
    catch let error as TestError {
      XCTAssert(v2 == error.error)
    }

    XCTAssertNotNil(detValue.value)
    XCTAssertNotNil(detError.error)

    XCTAssertNil(detValue.error)
    XCTAssertNil(detError.value)

    XCTAssertTrue(detValue.isValue)
    XCTAssertTrue(detError.isError)

    XCTAssertFalse(detValue.isError)
    XCTAssertFalse(detError.isValue)
  }

  func testEquals()
  {
#if swift(>=4.1)
    let i1 = nzRandom()
    let i2 = nzRandom()
    let i3 = i1*i2

    let o3 = Outcome(value: i1*i2)
    XCTAssert(o3 == Outcome(value: i3))
    XCTAssert(o3 != Outcome(value: i2))

    var o4 = o3
    o4 = Outcome(error: TestError(i1))
    XCTAssert(o3 != o4)
    XCTAssert(o4 != Outcome(error: TestError(i2)))
#else
    print("Skipped for Swift <4.1")
#endif
  }

  func testHashable()
  {
#if swift(>=4.1.50)
    let d1 = Outcome<Int>(value: nzRandom())
    let d2 = Outcome<Int>(error: TestError(nzRandom()))

    let set = Set([d1, d2])

    XCTAssert(set.contains(d1))
#else
    print("Skipped for Swift <4.2")
#endif
  }

  func testResult() throws
  {
#if swift(>=5.0)
    let i = nzRandom()
    var r = Result(Outcome(value: i))
    XCTAssertEqual(try r.get(), i)

    r = Result(Outcome(error: TestError(i)))
    do {
      _ = try r.get()
    }
    catch let error as TestError {
      XCTAssertEqual(error.error, i)
    }
#else
    print("Skipped for Swift <5.0")
#endif
  }
}
