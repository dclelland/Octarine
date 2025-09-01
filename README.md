# Octarine

An image conversion extension for Plinth, a hardware-accelerated matrix/numeric programming library for Swift.

## Installation

### Swift Package Manager

Simply add Octarine to your `Package.swift` file:

```swift
let package = Package(
    name: "Example",
    dependencies: [
        .package(url: "https://github.com/dclelland/Octarine.git", from: "0.1.0"),
    ],
    targets: [
        .target(name: "Example", dependencies: ["Octarine"])
    ]
)
```

Then import Octarine into your Swift files:

```swift
import Octarine
```

## Links

### Dependencies

- [apple/swift-numerics](https://github.com/apple/swift-numerics)
- [dclelland/Plinth](https://github.com/dclelland/Plinth)

## Todo

- [ ] Reinstantiate matrix validation
- [ ] `RGBImages.swift`: Add `RGBMatrix<UInt8>` support
- [ ] `Colormaps.swift`: `ComplexMatrix.saturation()` should call `Matrix.reciprocal()`

# Documentation

Work in progress...

<!--

## Core

### [RGBMatrix](Sources/Octarine/Core/RGBMatrix.swift)

Generic RGB matrix struct.

## Images

### [Images](Sources/Octarine/Extensions/Images/GrayImages.swift)

Conversion from `Matrix` to `vImage.PixelBuffer`, `CGImage`, `CIImage`, `NSImage`, and `UIImage` and vice versa.

### [Images](Sources/Octarine/Extensions/Images/RGBImages.swift)

Conversion from `RGBMatrix` to `vImage.PixelBuffer`, `CGImage`, `CIImage`, `NSImage`, and `UIImage` and vice versa.

## Colormaps

### [Images](Sources/Octarine/Extensions/Colormaps/Colormaps.swift)

An opinionated hue, saturation and brightness mapping for `ComplexMatrix`.

-->
