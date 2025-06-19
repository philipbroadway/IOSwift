//
//  Parser.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//

import Foundation

public struct Parser {
    private var tokens: [Token]
    private var current = 0

    public init(tokens: [Token]) {
        self.tokens = tokens
    }

    public mutating func parse() throws -> [Expr] {
        var expressions = [Expr]()
        while !isAtEnd {
            expressions.append(try parseExpression())
        }
        return expressions
    }

    private mutating func parseExpression() throws -> Expr {
        switch peek() {
        case .number(let value):
            advance()
            return .number(value)
        case .string(let text):
            advance()
            return .string(text)
        case .identifier(let name):
            advance()
            return .identifier(name)
        case .leftParen:
            return try parseList()
        case .leftBracket:
            return try parseMap()
        default:
            throw ParserError.unexpectedToken(peek())
        }
    }

    private mutating func parseList() throws -> Expr {
        // consume '('
        advance()
        var elements = [Expr]()
        while !isAtEnd && peek() != .rightParen {
            elements.append(try parseExpression())
        }
        try consume(.rightParen, message: "Expect ')' after list elements.")
        return .list(elements)
    }

    private mutating func parseMap() throws -> Expr {
        // consume '['
        advance()
        var entries = [(Expr, Expr)]()
        while !isAtEnd && peek() != .rightBracket {
            let key = try parseExpression()
            try consume(.symbol(":"), message: "Expect ':' between map key and value.")
            let value = try parseExpression()
            entries.append((key, value))
            if peek() == .comma {
                advance()
            }
        }
        try consume(.rightBracket, message: "Expect ']' after map entries.")
        return .map(entries)
    }

    // MARK: - Helpers

    private func peek() -> Token {
        tokens[current]
    }

    private mutating func advance() {
        if !isAtEnd { current += 1 }
    }

    private var isAtEnd: Bool {
        peek() == .eof
    }

    @discardableResult
    private mutating func consume(_ token: Token, message: String) throws -> Token {
        if peek() == token {
            let t = peek()
            advance()
            return t
        }
        throw ParserError.runtimeError(message)
    }
}

public enum ParserError: Error, CustomStringConvertible {
    case unexpectedToken(Token)
    case runtimeError(String)

    public var description: String {
        switch self {
        case .unexpectedToken(let token):
            return "Unexpected token: \(token)"
        case .runtimeError(let msg):
            return msg
        }
    }
}
