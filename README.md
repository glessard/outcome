# Outcome [![Build Status](https://travis-ci.org/glessard/outcome.svg?branch=master)](https://travis-ci.org/glessard/outcome)

An `Outcome<Value>` is a `Result<Value>` by another name.

Most Result types in Swift are implemented as a straight `enum`, which I find suboptimal because it introduces another shape for error handling that is different from the shape of Swift's native error handling, without actually being superior.

`Outcome` resolves this ambiguity by removing the option of switching over its cases; in order to get a `Value` out of it, you must `try` for the happy path and `catch` the possible errors.
