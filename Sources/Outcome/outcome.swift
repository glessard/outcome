//
//  outcome.swift
//
//  Created by Guillaume Lessard on 9/26/17.
//  Copyright © 2017 Guillaume Lessard. All rights reserved.
//

public struct Outcome<Success, Failure: Error>
{
  @usableFromInline let state: State<Success, Failure>

  @inlinable
  public init(value: Success)
  {
    state = .value(value)
  }

  @inlinable
  public init(error: Failure)
  {
    state = .error(error)
  }

  @inlinable
  public func get() throws -> Success
  {
    switch state
    {
    case .value(let value): return value
    case .error(let error): throw error
    }
  }

  public var value: Success? {
    @inlinable
    get {
      if case .value(let value) = state { return value }
      return nil
    }
  }

  public var error: Failure? {
    @inlinable
    get {
      if case .error(let error) = state { return error }
      return nil
    }
  }

  public var isValue: Bool {
    @inlinable
    get {
      if case .value = state { return true }
      return false
    }
  }

  public var isError: Bool {
    @inlinable
    get {
      if case .error = state { return true }
      return false
    }
  }
}

public struct AnyError: Error
{
  public var error: Error

  public init(_ error: Error)
  {
    self.error = error
  }
}

extension Outcome where Failure == AnyError
{
  @inlinable
  public init(error: Error)
  {
    state = .error(AnyError(error))
  }
}

extension Outcome: CustomStringConvertible
{
  public var description: String {
    switch state
    {
    case .value(let value): return "Success: " + String(describing: value)
    case .error(let error): return "Failure: \(error)"
    }
  }
}

extension Outcome: Equatable where Success: Equatable
{
  public static func ==(lhs: Outcome, rhs: Outcome) -> Bool
  {
    switch (lhs.state, rhs.state)
    {
    case (.value(let lhv), .value(let rhv)):
      return lhv == rhv
    case (.error(let lhe), .error(let rhe)):
      return String(describing: lhe) == String(describing: rhe)
    default:
      return false
    }
  }
}

extension Outcome: Hashable where Success: Hashable
{
  public func hash(into hasher: inout Hasher)
  {
    switch self.state
    {
    case .value(let value):
      Int(0).hash(into: &hasher)
      value.hash(into: &hasher)
    case .error(let error):
      Int(1).hash(into: &hasher)
      String(describing: error).hash(into: &hasher)
    }
  }
}

@usableFromInline
enum State<Success, Failure>
{
  case value(Success)
  case error(Failure)
}
