//
//  IOObjectString.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//


import Foundation

/// String IO object
public class IOObjectString: IOObject {
    public let value: String

    public init(_ value: String) {
        self.value = value
        super.init()
        slots["value"] = self
    }

    public override func perform(_ selector: String, args: [IOObject] = []) -> IOObject {
        switch selector {
        case "+":
            if let other = args.first as? IOObjectString {
                return IOObjectString(value + other.value)
            }
        default:
            break
        }
        return super.perform(selector, args: args)
    }
}
