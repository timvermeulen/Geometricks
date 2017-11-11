import CoreGraphics

extension CGFloat: Real {
    var sin: CGFloat { return CoreGraphics.sin(self) }
    var cos: CGFloat { return CoreGraphics.cos(self) }
    var tan: CGFloat { return CoreGraphics.tan(self) }
    
    var asin: CGFloat { return CoreGraphics.asin(self) }
    var acos: CGFloat { return CoreGraphics.acos(self) }
    var atan: CGFloat { return CoreGraphics.atan(self) }
    
    func cubeRoot() -> CGFloat {
        return self > 0 ? pow(self, 1 / 3) : -pow(-self, 1 / 3)
    }
    
    func atan2(_ x: CGFloat) -> CGFloat {
        return CoreGraphics.atan2(self, x)
    }
    
    static let tau: CGFloat = .pi * 2
}

extension Double: Real {
    var sin: Double { return Darwin.sin(self) }
    var cos: Double { return Darwin.cos(self) }
    var tan: Double { return Darwin.tan(self) }
    
    var asin: Double { return Darwin.asin(self) }
    var acos: Double { return Darwin.acos(self) }
    var atan: Double { return Darwin.atan(self) }
    
    func cubeRoot() -> Double {
        return self > 0 ? pow(self, 1 / 3) : -pow(-self, 1 / 3)
    }
    
    func atan2(_ x: Double) -> Double {
        return Darwin.atan2(self, x)
    }
    
    static let tau: Double = .pi * 2
}

extension Float: Real {
    var sin: Float { return Darwin.sin(self) }
    var cos: Float { return Darwin.cos(self) }
    var tan: Float { return Darwin.tan(self) }
    
    var asin: Float { return Darwin.asin(self) }
    var acos: Float { return Darwin.acos(self) }
    var atan: Float { return Darwin.atan(self) }
    
    func cubeRoot() -> Float {
        return self > 0 ? pow(self, 1 / 3) : -pow(-self, 1 / 3)
    }
    
    func atan2(_ x: Float) -> Float {
        return Darwin.atan2(self, x)
    }
    
    static let tau: Float = .pi * 2
}
