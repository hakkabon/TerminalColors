# TerminalColors

A Swift library for generating ANSI color escape sequences with support for 256-color palette and terminal styling.

## Overview

`TerminalColors` provides a type-safe, ergonomic API for adding colors and styles to terminal output using ANSI escape codes. Perfect for creating colorful command-line tools, logs, reports, and any text-based applications that need rich terminal output.

## Features

- **256-color palette support** - Access all 256 indexed ANSI colors by name
- **Styling capabilities** - Bold, dim, italic, blink, reversed, etc.
- **Foreground & background colors** - Easy combination of text color and background
- **Fluent API** - Chain styles together naturally
- **Protocol-based design** - Type-safe composition of styles

## Usage

### Basic Colors

```swift
// Import the library
import Foundation
import TerminalColors

let redText = "Error: 404" // styled with red foreground
let greenText = "Success message" // styled with green foreground
let blueBg = "Command output:\n\(blueBg: .bgBlue)"
```

### Styling Options

Available styles include:
- `reset` - Clear all styling
- `bold` - Bold text
- `dim` - Dimmed/faint text
- `italic` - Italic text (if supported)
- `blink` - Blinking text (on terminals that support it)
- `reversed` - Reverse foreground/background

Foreground colors: `.fgBlack`, `.fgRed`, `.fgGreen`, ... `.fgWhite`
Background colors: `.bgBlack`, `.bgRed`, `.bgGreen`, ... `.bgWhite`

### Combining Styles

You can chain multiple styles together:

```swift
let styledMessage = TerminalColor(fg: .fgCyan, bg: .bgDarkGray, _ bold: Style.bold)
print("Bold cyan on dark gray: \(styledMessage)")
```

## API Reference

### `ANSIStyle` Enum

Namespace containing:
- **Static helpers**: `escape(_:styling:)`, `reset`, `unescape`
- **Style enum**: Text style modifiers (bold, dim, italic, etc.)
- **Color enums**: 
  - `.fgBlack` through `.fgWhite` (16 foreground colors)
  - `.bgBlack` through `.bgWhite` (16 background colors)

### `ExtendedColor` Enum

All 256 indexed ANSI colors accessible by name:
```swift
enum ExtendedColor {
    case black = 0, maroon, green, olive, navy, purple, teal, silver, ...
    case blue = 9, fuchsia, aqua, white = 15, gray0, navyBlue, ...
    // ... all 256 colors (see source for full list)
}
```

### `TerminalColor` Struct

Aggregates styling options:

```swift
struct TerminalColor {
    let fg: ANSIStyle.ExtendedColor?
    let bg: ANSIStyle.ExtendedColor?
    let styles: [ANSIStyle.Style]

    init(fg: ANSIStyle.ExtendedColor? = nil,
         bg: ANSIStyle.ExtendedColor? = nil,
         _ styles: ANSIStyle.Style...)
}
```

### `ANSIStylable` Protocol

The core protocol that all style components conform to:

```swift
protocol ANSIStylable {
    var rawValue: Int { get }
    var escaped: String { get }
}
```

## Examples

### Colored Output in CLI Tools

```swift
func log(level: ExtendedColor, message: String) {
    let style = TerminalColor(fg: level, _ bold: Style.bold)
    print("\(style)\(message)")
}

log(level: .fgRed, message: "ERROR: Connection failed")
log(level: .fgGreen, message: "INFO: Server started")
log(level: .fgYellow, message: "WARN: Low memory")
```

### Status Indicators

```swift
let success = TerminalColor(fg: .fgGreen)
let error = TerminalColor(fg: .fgRed)
let warning = TerminalColor(fg: .fgYellow)

print("\(success)✓ Build succeeded in 12s")
print("\(error)✗ Compilation failed")
print("\(warning)⚠ Memory usage high")
```

### Tables and Logs with Background Colors

```swift
let header = TerminalStyle(fg: .fgWhite, bg: .bgBlue, _ bold: Style.bold)
let row = TerminalStyle(fg: .fgCyan, bg: .bgDarkGray)

print("\(header)Name\tValue")
print("\(row)CPU\t45%")
print("\(row)MEM\t2.1GB")
```

## Technical Details

- Built with Swift 5+ and conformant to Swift Package Manager standards
- Uses ANSI escape codes: `\u{001B}[<codes>m` format
- Supports both basic 16-color palette and extended 256-color LUT
- Compatible with modern terminals (iTerm2, Windows Terminal, GNOME Terminal, etc.)

## Installation

Add this package to your Swift project using the Swift Package Manager.

Add to your `Package.swift`:

```swift
dependencies: [
    .package(name: "TerminalColors", url: "https://github.com/hakkabon/TerminalColors.git")
]
```

Then import:

```swift
import TerminalColors
```

## License

MIT
