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

    let detValue = Outcome<Int, TestError>(value: v1)
    let detError = Outcome<Int, TestError>(error: TestError(v2))

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

  func testDescription()
  {
    let i1 = nzRandom()
    let o1 = Outcome<Int, TestError>(value: i1)
    let d1 = String(describing: o1)
    XCTAssert(d1.contains(String(describing: i1)))

    let e2 = TestError(nzRandom())
    let o2 = Outcome<Unicode.Scalar, AnyError>(error: e2)
    let d2 = String(describing: o2)
    XCTAssert(d2.contains(String(describing: e2)))
  }

  func testEquals()
  {
    let i1 = nzRandom()
    let i2 = nzRandom()
    let i3 = i1*i2

    let o3 = Outcome<Int, AnyError>(value: i1*i2)
    XCTAssert(o3 == Outcome<Int, AnyError>(value: i3))
    XCTAssert(o3 != Outcome<Int, AnyError>(value: i2))

    var o4 = o3
    o4 = Outcome(error: TestError(i1))
    XCTAssert(o3 != o4)
    XCTAssert(o4 != Outcome(error: TestError(i2)))
  }

  func testHashable()
  {
    let d1 = Outcome<Int, TestError>(value: nzRandom())
    let d2 = Outcome<Int, TestError>(error: TestError(nzRandom()))

    let set = Set([d1, d2])

    XCTAssert(set.contains(d1))
  }

  func testResult() throws
  {
#if compiler(>=5.0)
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
