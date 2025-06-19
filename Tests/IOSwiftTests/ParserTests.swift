//
//  ParserTests.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//


import Testing
@testable import IOSwift

final class ParserTests {
    @Test func testNumberExpression() throws {
        var parser = Parser(tokens: [.number(42), .eof])
        let exprs = try parser.parse()
        #expect(exprs == [.number(42)], "Expected [.number(42)], got \(exprs)")
    }

    @Test func testStringExpression() throws {
        var parser = Parser(tokens: [.string("hello"), .eof])
        let exprs = try parser.parse()
        #expect(exprs == [.string("hello")], "Expected [.string(\"hello\")], got \(exprs)")
    }

    @Test func testIdentifierExpression() throws {
        var parser = Parser(tokens: [.identifier("foo"), .eof])
        let exprs = try parser.parse()
        #expect(exprs == [.identifier("foo")], "Expected [.identifier(\"foo\")], got \(exprs)")
    }

    @Test func testListExpression() throws {
        var parser = Parser(tokens: [.leftParen, .number(1), .number(2), .rightParen, .eof])
        let exprs = try parser.parse()
        #expect(exprs == [.list([.number(1), .number(2)])], "Expected list of two numbers, got \(exprs)")
    }

    @Test func testNestedListExpression() throws {
        var parser = Parser(tokens: [
            .leftParen, .number(1), .leftParen, .number(2), .number(3), .rightParen, .rightParen, .eof
        ])
        let exprs = try parser.parse()
        let expected: Expr = .list([
            .number(1),
            .list([.number(2), .number(3)])
        ])
        #expect(exprs == [expected], "Expected nested list, got \(exprs)")
    }

    @Test func testMapExpression() throws {
        var parser = Parser(tokens: [.leftBracket, .string("key"), .symbol(":"), .number(1), .rightBracket, .eof])
        let exprs = try parser.parse()
        let expected: Expr = .map([(.string("key"), .number(1))])
        #expect(exprs == [expected], "Expected map with one entry, got \(exprs)")
    }
}
