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
        let a = IONumber(2)
        let b = IONumber(3)
        let result = a.perform("+", args: [b])
        // Unwrap the result and compare values directly
        guard let sum = result as? IONumber else {
            #expect(false, "Result is not IONumber")
            return
        }
        #expect(sum == IONumber(5), "2 + 3 should be 5, got \(sum.value)")
    }

    @Test func testStringConcatenation() throws {
        let a = IOString("foo")
        let b = IOString("bar")
        let result = a.perform("+", args: [b])
        // Unwrap the result and compare values directly
        guard let concat = result as? IOString else {
            #expect(false, "Result is not IOString")
            return
        }
        #expect(concat == IOString("foobar"), "foo + bar should be foobar, got \(concat.value)")
    }
}
