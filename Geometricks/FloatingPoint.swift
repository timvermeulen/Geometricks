// TODO: rename to `Real`
protocol FloatingPoint: Swift.FloatingPoint {
	var _sin: Self { get }
	var _cos: Self { get }
	var _tan: Self { get }
	
	var _asin: Self { get }
	var _acos: Self { get }
	var _atan: Self { get }
    
    func cubeRoot() -> Self
    func atan2(_ x: Self) -> Self
	
	static var pi: Self { get }
	static var tau: Self { get }
}

extension FloatingPoint {
	func mod(_ x: Self) -> Self {
		let rem = remainder(dividingBy: x)
		return rem < 0 ? rem + x : rem
	}
}

func sin<T: FloatingPoint>(_ x: T) -> T {
	return x._sin
}

func cos<T: FloatingPoint>(_ x: T) -> T {
	return x._cos
}

func tan<T: FloatingPoint>(_ x: T) -> T {
	return x._tan
}

func asin<T: FloatingPoint>(_ x: T) -> T {
	return x._asin
}

func acos<T: FloatingPoint>(_ x: T) -> T {
	return x._acos
}

func atan<T: FloatingPoint>(_ x: T) -> T {
	return x._atan
}
