//
//  IOCore.swift
//  IOSwift
//
//  Created by philipbroadway on 6/19/25.
//

import Foundation

/// Core methods registration
@MainActor
public struct IOCore {
    public static func registerCoreMethods(on globals: inout [String: IOObject]) {
        // Example: register arithmetic on Object prototype
        let objectProto = globals["Object"]!
        objectProto.slots["clone"] = IOCoreCloneMethod()
        objectProto.slots["do"] = IOCoreDoMethod()
    }
}

@MainActor
/// Method object intended to be called directly, not overrides of IOObject methods
public class IOCoreCloneMethod: IOObject {
    public func perform(_ receiver: IOObject, args: [IOObject]) -> IOObject {
        return receiver.clone()
    }
}

@MainActor
/// Method object intended to be called directly, not overrides of IOObject methods
public class IOCoreDoMethod: IOObject {
    public func perform(_ receiver: IOObject, args: [IOObject]) -> IOObject {
        return args.last ?? receiver
    }
}
