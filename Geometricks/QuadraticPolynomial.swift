struct QuadraticPolynomial<RawValue: FloatingPoint> {
	enum RealRoots {
		case zero
		case one(RawValue)
		case two(RawValue, RawValue)
	}
	
	let coefficients: (RawValue, RawValue, RawValue)
	
	init(_ c0: RawValue, _ c1: RawValue, _ c2: RawValue) {
		coefficients = (c0, c1, c2)
	}
	
	func evaluated(at x: RawValue) -> RawValue {
		return coefficients.0 + x * coefficients.1 + x * x * coefficients.2
	}
	
	var discriminant: RawValue {
		return coefficients.1 * coefficients.1 - 4 * coefficients.0 * coefficients.2
	}
	
	var realRoots: RealRoots {
		let discriminant = self.discriminant
		let minusB = -coefficients.1
		let twoA = 2 * coefficients.2
		
		guard discriminant >= 0 else { return .zero }
		guard discriminant > 0 else { return .one(minusB / twoA) }
		
		let root = discriminant.squareRoot()
		
		let solution0 = (minusB - root) / twoA
		let solution1 = (minusB + root) / twoA
		
		return .two(solution0, solution1)
	}
}
