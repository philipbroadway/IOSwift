//
//  IONumber.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//


import Foundation

/// Numeric IO object
public class IONumber: IOObject {
    public let value: Double
    
    public init(_ value: Double) {
        self.value = value
        super.init()
        // slot for retrieving raw value
        slots["value"] = self
    }
    
    public override func perform(_ selector: String, args: [IOObject] = []) -> IOObject {
        switch selector {
        case "+":
            if let other = args.first as? IONumber {
                return IONumber(value + other.value)
            }
        case "-":
            if let other = args.first as? IONumber {
                return IONumber(value - other.value)
            }
        default:
            break
        }
        return super.perform(selector, args: args)
    }
    
    public static func == (lhs: IONumber, rhs: IONumber) -> Bool {
        return lhs.value == rhs.value
    }
}
