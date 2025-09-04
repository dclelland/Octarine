//
//  RGBImages.swift
//  Octarine
//
//  Created by Daniel Clelland on 3/06/23.
//

import Foundation
import Accelerate
import CoreImage
import Plinth

#if os(macOS)

import AppKit

extension RGBMatrix where Scalar == UInt8 {

    public init?(nsImage: NSImage) {
        var rect = CGRect(x: 0, y: 0, width: nsImage.size.width, height: nsImage.size.height)
        guard let cgImage = nsImage.cgImage(forProposedRect: &rect, context: nil, hints: nil) else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
    
    public var nsImage: NSImage {
        return NSImage(cgImage: cgImage, size: NSSize(width: shape.columns, height: shape.rows))
    }
    
    public func nsImage(colorSpace: CGColorSpace) -> NSImage {
        return NSImage(cgImage: cgImage(colorSpace: colorSpace), size: NSSize(width: shape.columns, height: shape.rows))
    }

}

#elseif os(iOS)

import UIKit

extension RGBMatrix where Scalar == UInt8 {

    public init?(uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }

    public var uiImage: UIImage {
        return UIImage(cgImage: cgImage)
    }
    
    public func uiImage(colorSpace: CGColorSpace) -> CIImage {
        return UIImage(cgImage: cgImage(colorSpace: colorSpace))
    }

}

#endif

extension RGBMatrix where Scalar == UInt8 {

    public init?(ciImage: CIImage) {
        guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        self.init(cgImage: cgImage)
    }

    public var ciImage: CIImage {
        return CIImage(cgImage: cgImage)
    }
    
    public func ciImage(colorSpace: CGColorSpace) -> CIImage {
        return CIImage(cgImage: cgImage(colorSpace: colorSpace))
    }

}

extension RGBMatrix where Scalar == UInt8 {

    public init?(cgImage: CGImage) {
        var cgImageFormat = Self.cgImageFormat
        try? self.init(pixelBuffer: vImage.PixelBuffer<vImage.Interleaved8x3>(cgImage: cgImage, cgImageFormat: &cgImageFormat))
    }

    public var cgImage: CGImage {
        return pixelBuffer.makeCGImage(cgImageFormat: Self.cgImageFormat)!
    }
    
    public func cgImage(colorSpace: CGColorSpace) -> CGImage {
        return cgImage.copy(colorSpace: colorSpace)!
    }

    private static let cgImageFormat = vImage_CGImageFormat(
        bitsPerComponent: vImage.Interleaved8x3.bitCountPerComponent,
        bitsPerPixel: vImage.Interleaved8x3.bitCountPerPixel,
        colorSpace: CGColorSpaceCreateDeviceRGB(),
        bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
    )!

}

extension RGBMatrix where Scalar == UInt8 {
    
    public init(pixelBuffer: vImage.PixelBuffer<vImage.Interleaved8x3>) {
        let planarBuffers = pixelBuffer.planarBuffers()
        let redBuffer = planarBuffers[0]
        let greenBuffer = planarBuffers[1]
        let blueBuffer = planarBuffers[2]
        self.init(
            red: .init(shape: .init(rows: redBuffer.height, columns: redBuffer.width), elements: redBuffer.array),
            green: .init(shape: .init(rows: greenBuffer.height, columns: greenBuffer.width), elements: greenBuffer.array),
            blue: .init(shape: .init(rows: blueBuffer.height, columns: blueBuffer.width), elements: blueBuffer.array)
        )
    }

    public var pixelBuffer: vImage.PixelBuffer<vImage.Interleaved8x3> {
        return vImage.PixelBuffer<vImage.Interleaved8x3>(planarBuffers: [red.pixelBuffer, green.pixelBuffer, blue.pixelBuffer])
    }

}

#if os(macOS)

import AppKit

extension RGBMatrix where Scalar == Float {

    public init?(nsImage: NSImage) {
        var rect = CGRect(x: 0, y: 0, width: nsImage.size.width, height: nsImage.size.height)
        guard let cgImage = nsImage.cgImage(forProposedRect: &rect, context: nil, hints: nil) else {
            return nil
        }
        self.init(cgImage: cgImage)
    }
    
    public var nsImage: NSImage {
        return NSImage(cgImage: cgImage, size: NSSize(width: shape.columns, height: shape.rows))
    }
    
    public func nsImage(colorSpace: CGColorSpace) -> NSImage {
        return NSImage(cgImage: cgImage(colorSpace: colorSpace), size: NSSize(width: shape.columns, height: shape.rows))
    }

}

#elseif os(iOS)

import UIKit

extension RGBMatrix where Scalar == Float {

    public init?(uiImage: UIImage) {
        guard let cgImage = uiImage.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }

    public var uiImage: UIImage {
        return UIImage(cgImage: cgImage)
    }
    
    public func uiImage(colorSpace: CGColorSpace) -> CIImage {
        return UIImage(cgImage: cgImage(colorSpace: colorSpace))
    }

}

#endif

extension RGBMatrix where Scalar == Float {

    public init?(ciImage: CIImage) {
        guard let cgImage = CIContext().createCGImage(ciImage, from: ciImage.extent) else {
            return nil
        }
        self.init(cgImage: cgImage)
    }

    public var ciImage: CIImage {
        return CIImage(cgImage: cgImage)
    }
    
    public func ciImage(colorSpace: CGColorSpace) -> CIImage {
        return CIImage(cgImage: cgImage(colorSpace: colorSpace))
    }

}

extension RGBMatrix where Scalar == Float {

    public init?(cgImage: CGImage) {
        var cgImageFormat = Self.cgImageFormat
        try? self.init(pixelBuffer: vImage.PixelBuffer<vImage.InterleavedFx3>(cgImage: cgImage, cgImageFormat: &cgImageFormat))
    }

    public var cgImage: CGImage {
        return pixelBuffer.makeCGImage(cgImageFormat: Self.cgImageFormat)!
    }
    
    public func cgImage(colorSpace: CGColorSpace) -> CGImage {
        return cgImage.copy(colorSpace: colorSpace)!
    }

    private static let cgImageFormat = vImage_CGImageFormat(
        bitsPerComponent: vImage.InterleavedFx3.bitCountPerComponent,
        bitsPerPixel: vImage.InterleavedFx3.bitCountPerPixel,
        colorSpace: CGColorSpaceCreateDeviceRGB(),
        bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue | CGBitmapInfo.floatComponents.rawValue | CGBitmapInfo.byteOrder32Little.rawValue)
    )!

}

extension RGBMatrix where Scalar == Float {
    
    public init(pixelBuffer: vImage.PixelBuffer<vImage.InterleavedFx3>) {
        let planarBuffers = pixelBuffer.planarBuffers()
        let redBuffer = planarBuffers[0]
        let greenBuffer = planarBuffers[1]
        let blueBuffer = planarBuffers[2]
        self.init(
            red: .init(shape: .init(rows: redBuffer.height, columns: redBuffer.width), elements: redBuffer.array),
            green: .init(shape: .init(rows: greenBuffer.height, columns: greenBuffer.width), elements: greenBuffer.array),
            blue: .init(shape: .init(rows: blueBuffer.height, columns: blueBuffer.width), elements: blueBuffer.array)
        )
    }

    public var pixelBuffer: vImage.PixelBuffer<vImage.InterleavedFx3> {
        return vImage.PixelBuffer<vImage.InterleavedFx3>(planarBuffers: [red.pixelBuffer, green.pixelBuffer, blue.pixelBuffer])
    }

}
