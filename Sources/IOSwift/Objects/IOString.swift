//
//  IOString.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//


import Foundation

/// String IO object
public class IOString: IOObject {
    public let value: String

    public init(_ value: String) {
        self.value = value
        super.init()
        slots["value"] = self
    }

    public override func perform(_ selector: String, args: [IOObject] = []) -> IOObject {
        switch selector {
        case "+":
            if let other = args.first as? IOString {
                return IOString(value + other.value)
            }
        default:
            break
        }
        return super.perform(selector, args: args)
    }
    
    public static func == (lhs: IOString, rhs: IOString) -> Bool {
            return lhs.value == rhs.value
        }
}
