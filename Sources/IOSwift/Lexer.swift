//
//  Lexer.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//

import Foundation

public enum Token: Equatable, Sendable {
    case identifier(String)
    case number(Double)
    case string(String)
    case symbol(String)    // e.g., "+", "-", "=", etc.
    case leftParen
    case rightParen
    case leftBracket
    case rightBracket
    case dot
    case comma
    case eof
}

public struct Lexer {
    private let input: String
    private var currentIndex: String.Index

    public init(_ source: String) {
        self.input = source
        self.currentIndex = input.startIndex
    }

    public mutating func nextToken() -> Token {
        skipWhitespace()
        guard !isAtEnd else { return .eof }

        // Multi-character symbols
        if peek() == ":" && peekNext() == "=" {
            advance()
            advance()
            return .symbol(":=")
        }

        let char = peek()
        switch char {
        case "(": advance(); return .leftParen
        case ")": advance(); return .rightParen
        case "[": advance(); return .leftBracket
        case "]": advance(); return .rightBracket
        case ".": advance(); return .dot
        case ",": advance(); return .comma
        case "\"": return readString()
        default:
            if isDigit(char) || (char == "-" && isDigit(peekNext())) {
                return readNumberOrSymbol()
            } else if isIdentifierStart(char) {
                return readIdentifierOrSymbol()
            } else {
                // Single-character symbols
                advance()
                return .symbol(String(char))
            }
        }
    }

    // MARK: - Helpers

    private var isAtEnd: Bool {
        currentIndex >= input.endIndex
    }

    private func peek() -> Character {
        isAtEnd ? "�" : input[currentIndex]
    }

    private func peekNext() -> Character {
        let next = input.index(after: currentIndex)
        return next < input.endIndex ? input[next] : "�"
    }

    @discardableResult
    private mutating func advance() -> Character {
        let char = input[currentIndex]
        currentIndex = input.index(after: currentIndex)
        return char
    }

    private mutating func skipWhitespace() {
        while !isAtEnd && peek().isWhitespace {
            advance()
        }
    }

    private mutating func readString() -> Token {
        // consume opening quote
        advance()
        var value = ""
        while !isAtEnd && peek() != "\"" {
            value.append(advance())
        }
        // consume closing quote
        if !isAtEnd { advance() }
        return .string(value)
    }

    private mutating func readNumberOrSymbol() -> Token {
        var text = ""
        if peek() == "-" {
            text.append(advance())
        }
        while isDigit(peek()) {
            text.append(advance())
        }
        if peek() == "." {
            text.append(advance())
            while isDigit(peek()) {
                text.append(advance())
            }
        }
        if let value = Double(text) {
            return .number(value)
        }
        return .symbol(text)
    }

    private mutating func readIdentifierOrSymbol() -> Token {
        var text = ""
        while isIdentifierPart(peek()) {
            text.append(advance())
        }
        return .identifier(text)
    }

    private func isDigit(_ c: Character) -> Bool {
        c >= "0" && c <= "9"
    }

    private func isIdentifierStart(_ c: Character) -> Bool {
        c.isLetter || c == "_"
    }

    private func isIdentifierPart(_ c: Character) -> Bool {
        isIdentifierStart(c) || isDigit(c)
    }
}
