//
//  Bitmaps.swift
//  Plinth
//
//  Created by Daniel Clelland on 3/06/23.
//

import Foundation
import Plinth

extension Matrix where Scalar == Float {
    
    public init(bitmap matrix: Matrix<UInt8>) {
        self = .init(matrix) / 255.0
    }
    
}

extension Matrix where Scalar == Float {
    
    public var bitmap: Matrix<UInt8> {
        return Matrix<UInt8>(self * 255.0, rounding: .towardZero)
    }
    
}

extension RGBMatrix where Scalar == Float {
    
    public init(bitmap matrix: RGBMatrix<UInt8>) {
        self.init(
            red: .init(bitmap: matrix.red),
            green: .init(bitmap: matrix.green),
            blue: .init(bitmap: matrix.blue)
        )
    }
    
}

extension RGBMatrix where Scalar == Float {
    
    public var bitmap: RGBMatrix<UInt8> {
        return RGBMatrix<UInt8>(
            red: red.bitmap,
            green: green.bitmap,
            blue: blue.bitmap
        )
    }
    
}

extension Matrix where Scalar == Double {
    
    public init(bitmap matrix: Matrix<UInt8>) {
        self = .init(matrix) / 255.0
    }
    
}

extension Matrix where Scalar == Double {
    
    public var bitmap: Matrix<UInt8> {
        return Matrix<UInt8>(self * 255.0, rounding: .towardZero)
    }
    
}

extension RGBMatrix where Scalar == Double {
    
    public init(bitmap matrix: RGBMatrix<UInt8>) {
        self.init(
            red: .init(bitmap: matrix.red),
            green: .init(bitmap: matrix.green),
            blue: .init(bitmap: matrix.blue)
        )
    }
    
}

extension RGBMatrix where Scalar == Double {
    
    public var bitmap: RGBMatrix<UInt8> {
        return RGBMatrix<UInt8>(
            red: red.bitmap,
            green: green.bitmap,
            blue: blue.bitmap
        )
    }
    
}
