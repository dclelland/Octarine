//
//  Colormaps.swift
//  Octarine
//
//  Created by Daniel Clelland on 07/04/2025.
//

import Foundation
import Accelerate
import CoreImage
import Plinth

extension RGBMatrix where Scalar == Float {

    public init(hue: Matrix, saturation: Matrix, brightness: Matrix) {
        let sextant = hue * 6.0
        let chroma = brightness * saturation
        let match = brightness - chroma

        let sector = sextant.floor()
        let sectors = (0..<6).map { sector == Scalar($0) }
        let ramp = sextant.remainder(.init(shape: shape, repeating: 2.0)).absolute()
        let ramps = (0..<6).map { sectors[$0] * ramp }

        self.init(
            red: (ramps[4] + sectors[5] + sectors[0] + ramps[1]) * chroma + match,
            green: (ramps[0] + sectors[1] + sectors[2] + ramps[3]) * chroma + match,
            blue: (ramps[2] + sectors[3] + sectors[4] + ramps[5]) * chroma + match
        )
    }

}

extension ComplexMatrix where Scalar == Float {

    public var colormap: RGBMatrix<Scalar> {
        return RGBMatrix(hue: hue, saturation: saturation, brightness: brightness)
    }

}

extension ComplexMatrix where Scalar == Float {

    public var hue: Matrix {
        return (phase() + (2.0 * .pi))
            .truncatingRemainder(.init(shape: shape, repeating: 2.0 * .pi))
            .normalized(from: 0.0...(2.0 * .pi))
    }

    public var saturation: Matrix {
        return 1.0 / absolute()
            .threshold(to: 1.0, with: .clampToThreshold),
    }

    public var brightness: Matrix {
        return absolute()
            .clip(to: 0.0...1.0)
    }

}
