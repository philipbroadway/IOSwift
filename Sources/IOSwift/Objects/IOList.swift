//
//  IOList.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//


import Foundation

/// List prototype: holds ordered elements
public class IOList: IOObject {
    private var elements: [IOObject] = []

    public override init() {
        super.init()
        slots["add"] = IOObject() // placeholder
        slots["size"] = IOObject() // placeholder
    }

    public func add(_ element: IOObject) {
        elements.append(element)
    }

    public func size() -> Int {
        elements.count
    }
}
