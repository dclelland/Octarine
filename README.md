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

- [x] `RGBImages.swift`: Add `RGBMatrix<Float>.init(pixelBuffer:)` initialisation support
- [x] `RGBImages.swift`: Add `RGBMatrix<UInt8>` support
- [ ] `Colormaps.swift`: `ComplexMatrix.saturation()` should call `Matrix.reciprocal()`
- [ ] Reinstantiate matrix validation

# Documentation

Work in progress...

<!--

## Core

### [RGBMatrix](Sources/Octarine/Core/RGBMatrix.swift)

Generic RGB matrix struct.

## Images

### [GrayImages](Sources/Octarine/Extensions/Images/GrayImages.swift)

Conversion from `Matrix` to `vImage.PixelBuffer`, `CGImage`, `CIImage`, `NSImage`, and `UIImage` and vice versa.

### [RGBImages](Sources/Octarine/Extensions/Images/RGBImages.swift)

Conversion from `RGBMatrix` to `vImage.PixelBuffer`, `CGImage`, `CIImage`, `NSImage`, and `UIImage` and vice versa.

## Bitmaps

### [Bitmaps](Sources/Octarine/Extensions/Bitmaps/Bitmaps.swift)

Conversion to and from floating point formats in the range `0.0...1.0` to 8-bit bitmaps in the range `0...255`.

## Colormaps

### [Images](Sources/Octarine/Extensions/Colormaps/Colormaps.swift)

An opinionated hue, saturation and brightness mapping for `ComplexMatrix`.

-->
