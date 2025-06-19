# IOSwift

> [IO](https://iolanguage.org) Interpreter in Swift

├── Package.swift
├── Sources/
│   └── IoSwift/
│       ├── Io.swift           // Entry point & core runtime
│       ├── Lexer.swift        // Tokenizer
│       ├── Parser.swift       // Builds AST
│       ├── AST.swift          // AST node definitions
│       ├── VM.swift           // Virtual machine & message dispatch
│       ├── Objects/           // Prototype objects
│       │   ├── IoObject.swift
│       │   ├── IoMap.swift
│       │   ├── IoList.swift
│       │   └── …
│       └── Builtins/          // Core slots & functions
│           ├── IoCore.swift
│           └── …
└── Tests/
    └── IoSwiftTests/
        └── IoSwiftTests.swift // Unit tests for each component
