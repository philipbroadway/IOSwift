//
//  AST.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//

import Foundation

public indirect enum Expr: Equatable {
    case number(Double)
    case string(String)
    case identifier(String)
    case list([Expr])
    case map([(Expr, Expr)])

    public static func == (lhs: Expr, rhs: Expr) -> Bool {
        switch (lhs, rhs) {
        case (.number(let l), .number(let r)):
            return l == r
        case (.string(let l), .string(let r)):
            return l == r
        case (.identifier(let l), .identifier(let r)):
            return l == r
        case (.list(let l), .list(let r)):
            return l == r
        case (.map(let l), .map(let r)):
            return l.count == r.count && zip(l, r).allSatisfy { $0.0 == $1.0 && $0.1 == $1.1 }
        default:
            return false
        }
    }
}
