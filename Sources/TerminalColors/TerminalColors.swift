//
//  TerminalColors.swift
//  TerminalColors
//
//  Created by Ulf Akerstedt-Inoue on 2026/04/20.
//  Copyright © 2026 hakkabon software. All rights reserved.
//

import Foundation

public struct TerminalColor {
    let fg: ANSIStyle.ExtendedColor?
    let bg: ANSIStyle.ExtendedColor?
    let styles: [ANSIStyle.Style]

    /// Initializes a terminal color configuration with optional foreground, background, and style attributes.
    ///
    /// - Parameters:
    ///   - fg: Optional foreground color using `ANSIStyle.ExtendedColor` (defaults to nil)
    ///   - bg: Optional background color using `ANSIStyle.ExtendedColor` (defaults to nil)
    ///   - styles: Variable number of style attributes from `ANSIStyle.Style` (defaults to empty)
    public init(fg: ANSIStyle.ExtendedColor? = nil, bg: ANSIStyle.ExtendedColor? = nil, _ styles: ANSIStyle.Style...) {
        self.fg = fg
        self.bg = bg
        self.styles = styles
    }
}

extension DefaultStringInterpolation {

    /// Appends a value with the specified terminal color styling to the string interpolation.
    ///
    /// This method applies the given terminal color configuration (including foreground color,
    /// background color, and style attributes) to the value and appends it to the string
    /// interpolation. The color styling is automatically reset after the value.
    ///
    /// - Parameters:
    ///   - value: The value to be styled and appended to the string interpolation
    ///   - color: The `TerminalColor` configuration specifying the styling to apply
    public mutating func appendInterpolation(_ value: CustomStringConvertible, color: TerminalColor) {
        let style = ANSIStyle.escape(fg: color.fg, bg: color.bg, styles: color.styles)
        appendInterpolation("\(style)\(value)\(ANSIStyle.Style.reset.escaped)")
    }
}
