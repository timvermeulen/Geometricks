import CoreGraphics

extension CGFloat: FloatingPoint {
	var _sin: CGFloat { return sin(self) }
	var _cos: CGFloat { return cos(self) }
	var _tan: CGFloat { return tan(self) }
	
	var _asin: CGFloat { return asin(self) }
	var _acos: CGFloat { return acos(self) }
	var _atan: CGFloat { return atan(self) }
    
    func cubeRoot() -> CGFloat {
        return self > 0 ? pow(self, 1 / 3) : -pow(-self, 1 / 3)
    }
    
    func atan2(_ x: CGFloat) -> CGFloat {
        return CoreGraphics.atan2(self, x)
    }
	
	static let tau: CGFloat = .pi * 2
}

extension Double: FloatingPoint {
    var _sin: Double { return sin(self) }
	var _cos: Double { return cos(self) }
	var _tan: Double { return tan(self) }
	
	var _asin: Double { return asin(self) }
	var _acos: Double { return acos(self) }
	var _atan: Double { return atan(self) }
    
    func cubeRoot() -> Double {
        return self > 0 ? pow(self, 1 / 3) : -pow(-self, 1 / 3)
    }
    
    func atan2(_ x: Double) -> Double {
        return Darwin.atan2(self, x)
    }
	
	static let tau: Double = .pi * 2
}

extension Float: FloatingPoint {
	var _sin: Float { return sin(self) }
	var _cos: Float { return cos(self) }
	var _tan: Float { return tan(self) }
	
	var _asin: Float { return asin(self) }
	var _acos: Float { return acos(self) }
	var _atan: Float { return atan(self) }
    
    func cubeRoot() -> Float {
        return self > 0 ? pow(self, 1 / 3) : -pow(-self, 1 / 3)
    }
    
    func atan2(_ x: Float) -> Float {
        return Darwin.atan2(self, x)
    }
	
	static let tau: Float = .pi * 2
}
