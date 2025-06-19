//
//  IOMap.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//


import Foundation

/// Map prototype: holds key-value pairs
public class IOMap: IOObject {
    private var storage: [IOObject: IOObject] = [:]

    public override init() {
        super.init()
        // Initialize map-specific slots
        slots["at"] = IOObject() // placeholder
    }

    public func at(key: IOObject) -> IOObject? {
        storage[key]
    }

    public func at_put(key: IOObject, value: IOObject) {
        storage[key] = value
    }
}
