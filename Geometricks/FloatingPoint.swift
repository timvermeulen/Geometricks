protocol FloatingPoint: Swift.FloatingPoint {
	var _sin: Self { get }
}

func sin<T: FloatingPoint>(_ x: T) -> T {
	return x._sin
}

extension Double: FloatingPoint {
	var _sin: Double { return sin(self) }
}

extension Float: FloatingPoint {
	var _sin: Float { return sin(self) }
}
