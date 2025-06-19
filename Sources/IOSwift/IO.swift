//
//  IO.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//

import Foundation

/// Entry point for IOSwift runtime
@MainActor
public class IO {
    private var globals: [String: IOObject] = [:]

    public init() {
        // Initialize core prototypes
        globals["Object"] = IOObject()
        globals["List"] = IOList()
        globals["Map"] = IOMap()

        // Wire up builtins
        IOCore.registerCoreMethods(on: &globals)
    }

    /// Evaluate a sequence of expressions
    public func evaluate(_ exprs: [Expr]) -> IOObject? {
        var result: IOObject?
        for expr in exprs {
            result = evaluate(expr)
        }
        return result
    }

    private func evaluate(_ expr: Expr) -> IOObject? {
        switch expr {
        case .number(let n):
            let obj = IOObject()
            obj.slots["value"] = IONumber(n)
            return obj
        case .string(let s):
            let obj = IOObject()
            obj.slots["value"] = IOString(s)
            return obj
        case .identifier(let name):
            return globals[name]
        case .list(let elements):
            // For simplicity, treat first element as selector
            guard let first = elements.first,
                  case .identifier(let selector) = first else { return nil }
            let args = elements.dropFirst().compactMap { evaluate($0) }
            let receiver = globals[selector] ?? globals["Object"]!
            return receiver.perform(selector, args: args)
        case .map:
            // Map literal evaluation omitted for brevity
            return nil
        }
    }
}
