//
//  outcome.swift
//
//  Created by Guillaume Lessard on 9/26/17.
//  Copyright © 2017 Guillaume Lessard. All rights reserved.
//

public struct Outcome<Value>
{
  @usableFromInline let state: State<Value>

  @inlinable
  public init(value: Value)
  {
    state = .value(value)
  }

  @inlinable
  public init(error: Error)
  {
    state = .error(error)
  }

  @inlinable
  public func get() throws -> Value
  {
    switch state
    {
    case .value(let value): return value
    case .error(let error): throw error
    }
  }

  public var value: Value? {
    @inlinable
    get {
      if case .value(let value) = state { return value }
      return nil
    }
  }

  public var error: Error? {
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

#if compiler(>=5.0)
extension Result where Failure == Swift.Error
{
  public init(_ outcome: Outcome<Success>)
  {
    self.init(catching: outcome.get)
  }
}
#endif

extension Outcome: CustomStringConvertible
{
  public var description: String {
    switch state
    {
    case .value(let value): return "Value: " + String(describing: value)
    case .error(let error): return "Error: \(error)"
    }
  }
}

extension Outcome: Equatable where Value: Equatable
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

extension Outcome: Hashable where Value: Hashable
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
enum State<Value>
{
  case value(Value)
  case error(Error)
}
