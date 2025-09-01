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

}

extension RGBMatrix where Scalar == Float {

    public init?(cgImage: CGImage) {
        var cgImageFormat = Self.cgImageFormat
        try? self.init(pixelBuffer: vImage.PixelBuffer<vImage.InterleavedFx3>(cgImage: cgImage, cgImageFormat: &cgImageFormat))
    }

    public var cgImage: CGImage {
        return pixelBuffer.makeCGImage(cgImageFormat: Self.cgImageFormat)!
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
        fatalError()
        // self.init(shape: .init(rows: pixelBuffer.height, columns: pixelBuffer.width), elements: pixelBuffer.array)
    }

    public var pixelBuffer: vImage.PixelBuffer<vImage.InterleavedFx3> {
        return vImage.PixelBuffer<vImage.InterleavedFx3>(planarBuffers: [red.pixelBuffer, green.pixelBuffer, blue.pixelBuffer])
    }

}
