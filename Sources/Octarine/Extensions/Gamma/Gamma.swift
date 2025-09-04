//
//  File.swift
//  Octarine
//
//  Created by Daniel Clelland on 04/09/2025.
//

import Foundation
import Plinth

public enum GammaExponent<Scalar> { }

extension GammaExponent where Scalar == Float {
    
    public static let sRGB: Scalar = 2.2
    
}

extension Matrix where Scalar == Float {
    
    public func gammaEncoded(exponent: Scalar = GammaExponent.sRGB) -> Matrix {
        return pow(.init(shape: shape, repeating: 1.0 / exponent))
    }
    
    public func gammaDecoded(exponent: Scalar = GammaExponent.sRGB) -> Matrix {
        return pow(.init(shape: shape, repeating: exponent))
    }
    
}

extension RGBMatrix where Scalar == Float {
    
    public func gammaEncoded(exponent: Scalar = GammaExponent.sRGB) -> RGBMatrix {
        return .init(channels: channels.map { $0.gammaEncoded(exponent: exponent) })
    }
    
    public func gammaDecoded(exponent: Scalar = GammaExponent.sRGB) -> RGBMatrix {
        return .init(channels: channels.map { $0.gammaDecoded(exponent: exponent) })
    }
    
}

extension GammaExponent where Scalar == Double {
    
    public static let sRGB: Scalar = 2.2
    
}

extension Matrix where Scalar == Double {
    
    public func gammaEncoded(exponent: Scalar = GammaExponent.sRGB) -> Matrix {
        return pow(.init(shape: shape, repeating: 1.0 / exponent))
    }
    
    public func gammaDecoded(exponent: Scalar = GammaExponent.sRGB) -> Matrix {
        return pow(.init(shape: shape, repeating: exponent))
    }
    
}

extension RGBMatrix where Scalar == Double {
    
    public func gammaEncoded(exponent: Scalar = GammaExponent.sRGB) -> RGBMatrix {
        return .init(channels: channels.map { $0.gammaEncoded(exponent: exponent) })
    }
    
    public func gammaDecoded(exponent: Scalar = GammaExponent.sRGB) -> RGBMatrix {
        return .init(channels: channels.map { $0.gammaDecoded(exponent: exponent) })
    }
    
}
