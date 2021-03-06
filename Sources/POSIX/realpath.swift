/*
 This source file is part of the Swift.org open source project

 Copyright 2015 - 2016 Apple Inc. and the Swift project authors
 Licensed under Apache License v2.0 with Runtime Library Exception

 See http://swift.org/LICENSE.txt for license information
 See http://swift.org/CONTRIBUTORS.txt for Swift project authors
*/


import var libc.errno
import func libc.free
import func libc.realpath

/**
 Resolves all symbolic links, extra "/" characters, and references to /./
 and /../ in the input.

 Resolves both absolute and relative paths and return the absolute
 pathname.  All components in the provided input must exist when realpath()
 is called.
*/
public func realpath(path: String...) throws -> String {
    let path = joinPathComponents(path)
    let rv = realpath(path, nil)
    guard rv != nil else { throw SystemError.realpath(errno, path) }
    defer { free(rv) }
    guard let rvv = String.fromCString(rv) else { throw SystemError.realpath(-1, path) }
    return rvv
}
