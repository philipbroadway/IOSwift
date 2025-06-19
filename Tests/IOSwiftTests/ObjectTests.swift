//
//  ObjectTests.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//


import Testing
@testable import IOSwift

final class ObjectTests {
    @Test func testIOObjectSlotLookupAndClone() throws {
        // Create base object and assign a slot
        let original = IOObject()
        let slotValue = IOObject()
        original.slots["foo"] = slotValue

        // perform should return the slot value
        let returned = original.perform("foo")
        #expect(returned === slotValue, "Expected perform(\"foo\") to return the same instance")

        // Clone should copy slots dictionary
        let clone = original.clone()
        #expect(clone !== original, "Clone should be distinct instance from original")
        #expect(clone.slots["foo"] === slotValue, "Clone should retain slot values")
    }

    @Test func testIOListAddAndSize() throws {
        let list = IOList()
        #expect(list.size() == 0, "New list should have size 0")

        let item1 = IOObject()
        let item2 = IOObject()
        list.add(item1)
        list.add(item2)

        #expect(list.size() == 2, "List size should be 2 after adding two elements")
    }

    @Test func testIOMapAtAndAtPut() throws {
        let map = IOMap()
        let key = IOObject()
        let value = IOObject()

        #expect(map.at(key: key) == nil, "at(key) should be nil when not set")
        map.at_put(key: key, value: value)
        #expect(map.at(key: key) === value, "at(key) should return the value after at_put")
    }
}
