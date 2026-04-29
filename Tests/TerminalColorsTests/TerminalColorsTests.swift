import Testing
@testable import TerminalColors

@Test func testTerminalColorInitialization() async throws {
    // Test basic TerminalColor initialization
    let color = TerminalColor(fg: .red, bg: .blue, .bold, .italic)
    #expect(color.fg == .red)
    #expect(color.bg == .blue)
    #expect(color.styles.count == 2)
    #expect(color.styles.contains(.bold))
    #expect(color.styles.contains(.italic))
}

@Test func testTerminalColorWithNoStyles() async throws {
    // Test TerminalColor with no additional styles
    let color = TerminalColor(fg: .green, bg: .white)
    #expect(color.fg == .green)
    #expect(color.bg == .white)
    #expect(color.styles.isEmpty)
}

@Test func testANSIStyleEscapeFunction() async throws {
    // Test ANSIStyle escape function with multiple styles
    let styles = [ANSIStyle.Style.bold, ANSIStyle.Style.italic]
    let result = ANSIStyle.escape(styles)

    // Should contain the escape sequence and style codes
    #expect(result.contains("\u{001B}["))
    #expect(result.contains("1")) // bold code
    #expect(result.contains("3")) // italic code
    #expect(result.hasSuffix("m"))
}

@Test func testANSIStyleEscapeWithColors() async throws {
    // Test ANSIStyle escape function with colors
    let fgColor = ANSIStyle.ExtendedColor.red
    let bgColor = ANSIStyle.ExtendedColor.blue
    let result = ANSIStyle.escape(fg: fgColor, bg: bgColor)

    // Should contain both foreground and background color codes
    #expect(result.contains("\u{001B}["))
    #expect(result.contains("38;5;9")) // red = 9, foreground
    #expect(result.contains("48;5;12")) // blue = 12, background
    #expect(result.hasSuffix("m"))
}
