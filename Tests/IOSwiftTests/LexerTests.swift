import Testing
@testable import IOSwift

final class LexerTests {
    @Test func testSingleSymbols() throws {
        var lexer = Lexer("()+-[],.")
        let expected: [Token] = [
            .leftParen, .rightParen,
            .symbol("+"), .symbol("-"), .leftBracket, .rightBracket,
            .comma, .dot,
            .eof
        ]
        for expectedToken in expected {
            let token = lexer.nextToken()
            #expect(token == expectedToken, "Expected \(expectedToken), got \(token)")
        }
    }

    @Test func testIdentifiersAndNumbers() throws {
        var lexer = Lexer("foo bar123 42 -3.14 baz")
        #expect(lexer.nextToken() == .identifier("foo"), "Expected identifier(foo)")
        #expect(lexer.nextToken() == .identifier("bar123"), "Expected identifier(bar123)")
        #expect(lexer.nextToken() == .number(42), "Expected number(42)")
        #expect(lexer.nextToken() == .number(-3.14), "Expected number(-3.14)")
        #expect(lexer.nextToken() == .identifier("baz"), "Expected identifier(baz)")
        #expect(lexer.nextToken() == .eof, "Expected eof")
    }

    @Test func testStringLiteral() throws {
        var lexer = Lexer("\"hello world\"")
        #expect(lexer.nextToken() == .string("hello world"), "Expected string(hello world)")
        #expect(lexer.nextToken() == .eof, "Expected eof after string")
    }

    @Test func testMixedInput() throws {
        var lexer = Lexer("""
sum := (a + b) // comment
  "test"
""")
        #expect(lexer.nextToken() == .identifier("sum"), "Expected identifier(sum)")
        #expect(lexer.nextToken() == .symbol(":="), "Expected symbol(:=)")
        #expect(lexer.nextToken() == .leftParen, "Expected leftParen")
        #expect(lexer.nextToken() == .identifier("a"), "Expected identifier(a)")
        #expect(lexer.nextToken() == .symbol("+"), "Expected symbol(+)")
        #expect(lexer.nextToken() == .identifier("b"), "Expected identifier(b)")
        #expect(lexer.nextToken() == .rightParen, "Expected rightParen")
        #expect(lexer.nextToken() == .symbol("/"), "Expected symbol(/)")
        #expect(lexer.nextToken() == .symbol("/"), "Expected symbol(/)")
        #expect(lexer.nextToken() == .identifier("comment"), "Expected identifier(comment)")
        #expect(lexer.nextToken() == .string("test"), "Expected string(test)")
        #expect(lexer.nextToken() == .eof, "Expected eof at end")
    }
}

