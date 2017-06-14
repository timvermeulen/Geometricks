struct CubicPolynomial<RawValue: Real> {
	private let coefficients: (RawValue, RawValue, RawValue, RawValue)
	
    init(_ c0: RawValue, _ c1: RawValue, _ c2: RawValue, _ c3: RawValue) {
		self.coefficients = (c0, c1, c2, c3)
	}
}

extension CubicPolynomial: NonConstantComplexSolvable {
	func evaluated(at x: RawValue) -> RawValue {
		let x2 = x * x
		let x3 = x * x2
		
		let t0 = coefficients.0
		let t1 = coefficients.1 * x
		let t2 = coefficients.2 * x2
		let t3 = coefficients.3 * x3
		
		return t0 + t1 + t2 + t3
	}
    
    var leadingCoefficient: RawValue {
        return coefficients.3
    }
    
    var constant: RawValue {
        return coefficients.0
    }
}

extension CubicPolynomial: NonConstantPolynomial {
	var _complexRoots: [Complex<RawValue>]? {
		let (a0, a1, a2, a3) = coefficients
		
		guard a2.isZero else {
			let a32 = a3 * a3
			let a33 = a32 * a3
			let a22 = a2 * a2
			let a23 = a22 * a2
			let pnum = (3 * a3 * a1 - a22)
			let p = pnum / (3 * a32)
			let nq0 = 2 * a23
			let nq1 = 9 * a3 * a2 * a1
			let nq2 = 27 * a32 * a0
			let nq = nq0 - nq1 + nq2
			let dq = 27 * a33
			let q = nq / dq
			let diff = -a2 / (3 * a3)
			
			return CubicPolynomial(q, p, 0, 1).complexRoots?.map { $0 + Complex(realPart: diff) }
		}
		
		let p = a1 / a3
		let q = a0 / a3
		let p3 = p / 3
		let q2 = q / 2
		let p27 = p3 * p3 * p3
		let q4 = q2 * q2
		let d = q4 + p27
		
		if d >= 0 {
			let zeta = Complex(realPart: -1 / 2, imaginaryPart: (3 as RawValue).squareRoot() / 2)
			let zeta2 = zeta.conjugate
			let sqD = d.squareRoot()
			
			let r1 = Complex(realPart: (-q2 + sqD).cubeRoot())
			let r2 = Complex(realPart: (-q2 - sqD).cubeRoot())
			
			let c0 = r1 + r2
			let c1 = r1 * zeta + r2 * zeta2
			let c2 = r1 * zeta2 + r2 * zeta
			
			return [c0, c1, c2]
		} else {
			let sqD = (-d).squareRoot()
			let angle = sqD.atan2(-q2)
			let norm3 = 2 * (-d + q4).squareRoot().cubeRoot()
			let angle3 = angle / 3
			let twoPiThirds = RawValue.pi * 2 / 3
			
			let c0 = norm3 * angle3.cos
			let c1 = norm3 * (angle3 + twoPiThirds).cos
			let c2 = norm3 * (angle3 - twoPiThirds).cos
			
			return [c0, c1, c2].map { Complex(realPart: $0) }
		}
	}
	
	var derivative: QuadraticPolynomial<RawValue> {
		return QuadraticPolynomial(coefficients.1, 2 * coefficients.2, 3 * coefficients.3)
	}
    
    var popped: QuadraticPolynomial<RawValue> {
        return QuadraticPolynomial(coefficients.0, coefficients.1, coefficients.2)
    }
    
    var shifted: QuadraticPolynomial<RawValue> {
        return QuadraticPolynomial(coefficients.1, coefficients.2, coefficients.3)
    }
}
