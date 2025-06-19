//
//  BuiltinTests.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//

import Testing
@testable import IOSwift

final class BuiltinTests {
    @Test func testNumberAddition() throws {
        let a = IOObjectNumber(2)
        let b = IOObjectNumber(3)
        let result = a.perform("+", args: [b])
        // Unwrap the result and compare values directly
        guard let sum = result as? IOObjectNumber else {
            #expect(false, "Result is not IOObjectNumber")
            return
        }
        #expect(sum == IOObjectNumber(5), "2 + 3 should be 5, got \(sum.value)")
    }

    @Test func testStringConcatenation() throws {
        let a = IOObjectString("foo")
        let b = IOObjectString("bar")
        let result = a.perform("+", args: [b])
        // Unwrap the result and compare values directly
        guard let concat = result as? IOObjectString else {
            #expect(false, "Result is not IOObjectString")
            return
        }
        #expect(concat == IOObjectString("foobar"), "foo + bar should be foobar, got \(concat.value)")
    }
}
