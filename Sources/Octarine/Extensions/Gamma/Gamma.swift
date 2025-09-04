//
//  File.swift
//  Octarine
//
//  Created by Daniel Clelland on 04/09/2025.
//

import Foundation
import Plinth

extension Matrix where Scalar == Float {
    
    public func gammaEncoded(exponent: Scalar = 2.2) -> Matrix {
        return pow(.init(shape: shape, repeating: 1.0 / exponent))
    }
    
    public func gammaDecoded(exponent: Scalar = 2.2) -> Matrix {
        return pow(.init(shape: shape, repeating: exponent))
    }
    
}

extension RGBMatrix where Scalar == Float {
    
    public func gammaEncoded(exponent: Scalar = 2.2) -> RGBMatrix {
        return .init(channels: channels.map { $0.gammaEncoded(exponent: exponent) })
    }
    
    public func gammaDecoded(exponent: Scalar = 2.2) -> RGBMatrix {
        return .init(channels: channels.map { $0.gammaDecoded(exponent: exponent) })
    }
    
}

extension Matrix where Scalar == Double {
    
    public func gammaEncoded(exponent: Scalar = 2.2) -> Matrix {
        return pow(.init(shape: shape, repeating: 1.0 / exponent))
    }
    
    public func gammaDecoded(exponent: Scalar = 2.2) -> Matrix {
        return pow(.init(shape: shape, repeating: exponent))
    }
    
}

extension RGBMatrix where Scalar == Double {
    
    public func gammaEncoded(exponent: Scalar = 2.2) -> RGBMatrix {
        return .init(channels: channels.map { $0.gammaEncoded(exponent: exponent) })
    }
    
    public func gammaDecoded(exponent: Scalar = 2.2) -> RGBMatrix {
        return .init(channels: channels.map { $0.gammaDecoded(exponent: exponent) })
    }
    
}
