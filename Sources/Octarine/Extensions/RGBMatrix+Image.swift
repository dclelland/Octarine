//
//  RGBMatrix+Image.swift
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

    public var nsImage: NSImage {
        return NSImage(cgImage: cgImage, size: NSSize(width: shape.columns, height: shape.rows))
    }

}

#elseif os(iOS)

import UIKit

extension RGBMatrix where Scalar == Float {

    public var uiImage: UIImage {
        return UIImage(cgImage: cgImage)
    }

}

#endif

extension RGBMatrix where Scalar == Float {

    public var ciImage: CIImage {
        return CIImage(cgImage: cgImage)
    }

}

extension RGBMatrix where Scalar == Float {

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

    public var pixelBuffer: vImage.PixelBuffer<vImage.InterleavedFx3> {
        return vImage.PixelBuffer<vImage.InterleavedFx3>(planarBuffers: [red.pixelBuffer, green.pixelBuffer, blue.pixelBuffer])
    }

}
