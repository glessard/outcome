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

  @inlinable
  public var value: Value? {
    if case .value(let value) = state { return value }
    return nil
  }

  @inlinable
  public var error: Error? {
    if case .error(let error) = state { return error }
    return nil
  }

  @inlinable
  public var isValue: Bool {
    if case .value = state { return true }
    return false
  }

  @inlinable
  public var isError: Bool {
    if case .error = state { return true }
    return false
  }
}

#if swift (>=4.1)
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
#endif

#if swift (>=4.2)
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
#endif

#if swift (>=4.2)
@usableFromInline
enum State<Value>
{
  case value(Value)
  case error(Error)
}
#else
enum State<Value>
{
case value(Value)
case error(Error)
}
#endif
