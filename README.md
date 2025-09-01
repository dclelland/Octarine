# Octarine

Image processing extension for Plinth, a hardware-accelerated matrix/numeric programming library for Swift.

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

### Core

- [ ] `RGBImage`
- [ ] `RGBPixel`

### Extensions

- [ ] `Matrix`
- [ ] `ComplexMatrix`
- [ ] `RGBImage`

# Documentation

Work in progress...

<!--
### [Images](Sources/Plinth/Extensions/Image%20Processing/Images.swift)

Conversion to and from `vImage.PixelBuffer`, `CGImage`, `CIImage`, `NSImage`, and `UIImage`.

### [ComplexImages](Sources/Plinth/Extensions/Image%20Processing/ComplexImages.swift)

Conversion to and from `vImage.PixelBuffer`, `CGImage`, `CIImage`, `NSImage`, and `UIImage`, using an opinionated colormap to represent complex values.
-->
