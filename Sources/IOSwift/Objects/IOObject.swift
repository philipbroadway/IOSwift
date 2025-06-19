//
//  IOObject.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//

import Foundation

/// Base class for all Io objects
public class IOObject: Hashable, Equatable {
    public var slots: [String: IOObject] = [:]

    public init() {}

    public static func == (lhs: IOObject, rhs: IOObject) -> Bool {
        return lhs === rhs
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }

    /// Send a message (selector) with optional arguments
    public func perform(_ selector: String, args: [IOObject] = []) -> IOObject {
        if let slot = slots[selector] {
            // If slot is a method, invoke it
            return slot
        }
        fatalError("Unknown selector: \(selector)")
    }

    /// Clone this object
    public func clone() -> IOObject {
        let copy = IOObject()
        copy.slots = slots
        return copy
    }
}
