# Outcome [![Build Status](https://travis-ci.org/glessard/outcome.svg?branch=master)](https://travis-ci.org/glessard/outcome)

An `Outcome<Value>` is a `Result<Value>` by another name.

Most Result types in Swift are implemented as a straight `enum`, which I find suboptimal because it introduces a pattern for error handling that is vastly different from Swift's native error handling pattern -- without actually being superior.

`Outcome` resolves this by not being an `enum` but an opaque `struct`. In order to get a `Value` out of it, one must `try` for the happy path and `catch` any possible `Error`.
