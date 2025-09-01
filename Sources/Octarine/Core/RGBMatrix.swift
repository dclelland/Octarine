//
//  RGBMatrix.swift
//  Octarine
//
//  Created by Daniel Clelland on 01/09/2025.
//

import Foundation
import Accelerate
import CoreImage
import Plinth

public typealias RGBPixel<Scalar> = (red: Scalar, green: Scalar, blue: Scalar)

public struct RGBMatrix<Scalar> where Scalar: Real {

    public typealias Matrix = Plinth.Matrix<Scalar>
    public typealias Pixel = RGBPixel<Scalar>

    public var red: Matrix
    public var green: Matrix
    public var blue: Matrix

    public init(red: Matrix, green: Matrix, blue: Matrix) {
        self.red = red
        self.green = green
        self.blue = blue
    }

    public init(shape: Shape, repeating element: Pixel) {
        self.init(
            red: .init(shape: shape, repeating: element.red),
            green: .init(shape: shape, repeating: element.green),
            blue: .init(shape: shape, repeating: element.blue)
        )
    }

    public init(shape: Shape, elements: [Pixel]) {
        self.init(
            red: .init(shape: shape, elements: elements.map(\.red)),
            green: .init(shape: shape, elements: elements.map(\.green)),
            blue: .init(shape: shape, elements: elements.map(\.blue))
        )
    }

    public init(shape: Shape, _ closure: @autoclosure () throws -> Pixel) rethrows {
        var elements: [Complex] = []
        elements.reserveCapacity(shape.count)
        for _ in 0..<shape.count {
            elements.append(try closure())
        }
        self.init(shape: shape, elements: elements)
    }

    public init(shape: Shape, _ closure: (_ row: Int, _ column: Int) throws -> Pixel) rethrows {
        var elements: [Complex] = []
        elements.reserveCapacity(shape.count)
        for row in shape.rowIndices {
            for column in shape.columnIndices {
                elements.append(try closure(row, column))
            }
        }
        self.init(shape: shape, elements: elements)
    }

}

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

extension RGBMatrix {

    public init(element: Pixel) {
        self.init(shape: .square(length: 1), elements: [element])
    }

    public init(row: [Pixel]) {
        self.init(shape: .row(length: row.count), elements: row)
    }

    public init(column: [Pixel]) {
        self.init(shape: .column(length: column.count), elements: column)
    }

    public init(grid: [[Pixel]]) {
        self.init(shape: .init(rows: grid.count, columns: grid.first?.count ?? 0), elements: Array(grid.joined()))
    }

}

extension RGBMatrix {

    public static var empty: RGBMatrix {
        return .init(shape: .empty, elements: [])
    }

}

extension RGBMatrix {

    public enum State: CustomStringConvertible {

        case regular
        case malformed(_ malformation: Malformation)

        public var description: String {
            switch self {
            case .regular:
                return "Regular"
            case .malformed(let malformation):
                return "Malformed: \(malformation)"
            }
        }

    }

    public struct Malformation: CustomStringConvertible {

        public let red: Matrix.Malformation?
        public let green: Matrix.Malformation?
        public let blue: Matrix.Malformation?

        // public var description: String {
        //     switch self {
        //     case .parts(let real, let imaginary):
        //         return "Malformed real part: \(real); Malformed imaginary part: \(imaginary)"
        //     case .realPart(let real):
        //         return "Malformed real part: \(real)"
        //     case .imaginaryPart(let imaginary):
        //         return "Malformed imaginary part: \(imaginary)"
        //     case .shapeMismatch(let real, let imaginary):
        //         return "Shape mismatch between real and imaginary parts; \(real) ≠ \(imaginary)"
        //     }
        // }

    }

    public var state: State {
        switch (red.state, green.state, blue.state) {
            case (.regular, .regular, .regular):
                return .regular
            default:
                return Malformation(red: red.state, green: green.state, blue: blue.state)
        }

        // switch (real.state, imaginary.state) {
        // case (.malformed(let real), .malformed(let imaginary)):
        //     return .malformed(.parts(real, imaginary))
        // case (.malformed(let real), .regular):
        //     return .malformed(.realPart(real))
        // case (.regular, .malformed(let imaginary)):
        //     return .malformed(.imaginaryPart(imaginary))
        // case (.regular, .regular):
        //     guard real.shape == imaginary.shape else {
        //         return .malformed(.shapeMismatch(real.shape, imaginary.shape))
        //     }

        //     return .regular
        // }
    }

    public var shape: Shape {
        return Shape(
            rows: Swift.min(red.shape.rows, green.shape.rows, blue.shape.rows),
            columns: Swift.min(red.shape.columns, green.shape.columns, blue.shape.columns)
        )
    }

}

extension RGBMatrix {

   public var elements: [Pixel] {
       return Array(self)
   }

   public var grid: [[Pixel]] {
       return shape.rowIndices.map { row in
           return Array(elements[shape.indicesFor(row: row)])
       }
   }

}

extension RGBMatrix {

   public subscript(row: Int, column: Int) -> Pixel {
       get {
           precondition(shape.contains(row: row, column: column))
           return (red: red[row, column], green: green[row, column], blue: blue[row, column])
       }
       set {
           precondition(shape.contains(row: row, column: column))
           red[row, column] = newValue.red
           green[row, column] = newValue.green
           blue[row, column] = newValue.blue
       }
   }

}

extension RGBMatrix: ExpressibleByArrayLiteral {

   public init(arrayLiteral elements: [Pixel]...) {
       self.init(grid: elements)
   }

}

extension RGBMatrix: CustomStringConvertible where Scalar: CustomStringConvertible {

   public var description: String {
       switch state {
       case .regular:
           return "[[" + grid.map { $0.map(\.description).joined(separator: ", ") }.joined(separator: "],\n [") + "]]"
       case .malformed(let malformation):
           return "Malformed \(type(of: self)): \(malformation)"
       }
   }

}

extension RGBMatrix: Equatable where Scalar: Equatable {

   public static func == (left: ComplexMatrix, right: ComplexMatrix) -> Bool {
       return left.red == right.red && left.green == right.green && left.blue == right.blue
   }

}

extension RGBMatrix: Hashable where Scalar: Hashable {

   public func hash(into hasher: inout Hasher) {
       hasher.combine(red)
       hasher.combine(green)
       hasher.combine(blue)
   }

}

extension RGBMatrix: Codable where Scalar: Codable {

   enum CodingKeys: String, CodingKey {
       case red
       case green
       case blue
   }

   public init(from decoder: Decoder) throws {
       let container = try decoder.container(keyedBy: CodingKeys.self)
       self.red = try container.decode(Matrix.self, forKey: .red)
       self.green = try container.decode(Matrix.self, forKey: .green)
       self.blue = try container.decode(Matrix.self, forKey: .blue)
       if case .malformed(let malformation) = self.state {
           throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "Malformed \(type(of: self)): \(malformation)"))
       }
   }

   public func encode(to encoder: Encoder) throws {
       if case .malformed(let malformation) = self.state {
           throw EncodingError.invalidValue(self, .init(codingPath: encoder.codingPath, debugDescription: "Malformed \(type(of: self)): \(malformation)"))
       }
       var container = encoder.container(keyedBy: CodingKeys.self)
       try container.encode(red, forKey: .red)
       try container.encode(green, forKey: .green)
       try container.encode(blue, forKey: .blue)
   }

}

extension RGBMatrix: Collection {

   public typealias Index = Int

   public var startIndex: Index {
       return 0
   }

   public var endIndex: Index {
       return Swift.min(red.count, green.count, blue.count)
   }

   public func index(after index: Index) -> Index {
       return index + 1
   }

   public subscript(_ index: Index) -> Pixel {
       return Complex(red[index], green[index], blue[index])
   }

}

extension RGBMatrix: BidirectionalCollection {

   public func index(before index: Index) -> Index {
       return index - 1
   }

   public func reversed() -> RGBMatrix {
       return RGBMatrix(red: red.reversed(), green: green.reversed(), blue: blue.reversed())
   }

}
