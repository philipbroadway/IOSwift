//
//  IOSwiftTests.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//

import Testing
@testable import IOSwift

@MainActor
final class IOSwiftTests {
    @Test func testEvaluateNumber() throws {
        let io = IO()
        let exprs: [Expr] = [.number(7)]
        let result = io.evaluate(exprs)
        guard let obj = result else {
            #expect(false, "Expected non-nil result for number evaluation")
            return
        }
        guard let num = obj.slots["value"] as? IONumber else {
            #expect(false, "Expected slot \"value\" to be IONumber")
            return
        }
        #expect(num == IONumber(7), "Expected value 7, got \(num.value)")
    }

    @Test func testEvaluateString() throws {
        let io = IO()
        let exprs: [Expr] = [.string("test")]  
        let result = io.evaluate(exprs)
        guard let obj = result else {
            #expect(false, "Expected non-nil result for string evaluation")
            return
        }
        guard let str = obj.slots["value"] as? IOString else {
            #expect(false, "Expected slot \"value\" to be IOString")
            return
        }
        #expect(str == IOString("test"), "Expected \"test\", got \(str.value)")
    }

    @Test func testEvaluateIdentifier() throws {
        let io = IO()
        // Should retrieve the global Object prototype
        let exprs: [Expr] = [.identifier("Object")]
        let result = io.evaluate(exprs)
        guard let obj = result else {
            #expect(false, "Expected non-nil result for identifier evaluation")
            return
        }
        // The Object prototype is stored in globals under "Object"
        let expected = IOObject()
        #expect(type(of: obj) == type(of: expected), "Expected an IOObject instance for global prototype")
    }
}
