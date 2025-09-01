//
//  ComplexMatrix+Image.swift
//  Octarine
//
//  Created by Daniel Clelland on 07/04/2025.
//

import Foundation
import Accelerate
import CoreImage
import Plinth

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
