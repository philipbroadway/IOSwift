# IOSwift

> [IO](https://iolanguage.org) Interpreter in Swift

```text
├── Package.swift
├── Sources/
│   └── IoSwift/
│       ├── IO.swift           // Entry point & core runtime
│       ├── Lexer.swift        // Tokenizer
│       ├── Parser.swift       // Builds AST
│       ├── AST.swift          // AST node definitions
│       ├── VM.swift           // Virtual machine & message dispatch
│       ├── Objects/           // Prototype objects
│       │   ├── IOObject.swift
│       │   ├── IOMap.swift
│       │   ├── IOList.swift
|       │   ├── IOString.swift
|       │   ├── IONumber.swift
│       │   └── …
│       └── Builtins/          // Core slots & functions
│           ├── IOCore.swift
│           └── …
└── Tests/
    └── IoSwiftTests/
        └── IoSwiftTests.swift // Unit tests for each component
```
