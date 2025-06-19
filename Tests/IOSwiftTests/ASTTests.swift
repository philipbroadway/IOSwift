//
//  ASTTests.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//

import Testing
@testable import IOSwift

final class ASTTests {
    @Test func testNumberEquality() throws {
        let a = Expr.number(1.0)
        let b = Expr.number(1.0)
        let c = Expr.number(2.0)
        #expect(a == b, "Expected 1.0 == 1.0")
        #expect(a != c, "Expected 1.0 != 2.0")
    }

    @Test func testStringEquality() throws {
        let a = Expr.string("foo")
        let b = Expr.string("foo")
        let c = Expr.string("bar")
        #expect(a == b, "Expected \"foo\" == \"foo\"")
        #expect(a != c, "Expected \"foo\" != \"bar\"")
    }

    @Test func testIdentifierEquality() throws {
        let a = Expr.identifier("x")
        let b = Expr.identifier("x")
        let c = Expr.identifier("y")
        #expect(a == b, "Expected x == x")
        #expect(a != c, "Expected x != y")
    }

    @Test func testListEquality() throws {
        let a = Expr.list([.number(1), .number(2)])
        let b = Expr.list([.number(1), .number(2)])
        let c = Expr.list([.number(2), .number(1)])
        #expect(a == b, "Expected [1,2] == [1,2]")
        #expect(a != c, "Expected [1,2] != [2,1]")
    }

    @Test func testMapEquality() throws {
        let entry1: (Expr, Expr) = (.string("key"), .number(1))
        let entry2: (Expr, Expr) = (.string("key"), .number(1))
        let entry3: (Expr, Expr) = (.string("key"), .number(2))
        let a = Expr.map([entry1])
        let b = Expr.map([entry2])
        let c = Expr.map([entry3])
        #expect(a == b, "Expected map entry1 == entry2")
        #expect(a != c, "Expected map entry1 != entry3")
    }
}
