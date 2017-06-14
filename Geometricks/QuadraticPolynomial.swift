struct QuadraticPolynomial<RawValue: Real> {
	private let coefficients: (RawValue, RawValue, RawValue)
	
	init(_ c0: RawValue, _ c1: RawValue, _ c2: RawValue) {
		coefficients = (c0, c1, c2)
	}
}

extension QuadraticPolynomial: NonConstantComplexSolvable {
	func evaluated(at x: RawValue) -> RawValue {
		return coefficients.0 + x * coefficients.1 + x.squared() * coefficients.2
	}
    
    var leadingCoefficient: RawValue {
        return coefficients.2
    }
    
    var constant: RawValue {
        return coefficients.0
    }
}

extension QuadraticPolynomial: NonConstantPolynomial {
    var _complexRoots: [Complex<RawValue>]? {
        let discriminant: RawValue = coefficients.1.squared() - 4 * coefficients.0 * coefficients.2
        let minusTwoA: RawValue = -2 * coefficients.2
        let root = Complex.squareRoot(of: discriminant)
		
		return [
			(Complex(realPart: coefficients.1) - root) / minusTwoA,
			(Complex(realPart: coefficients.1) + root) / minusTwoA
		]
    }
    
    var derivative: LinearPolynomial<RawValue> {
        return LinearPolynomial(coefficients.1, 2 * coefficients.2)
    }
    
    var popped: LinearPolynomial<RawValue> {
        return LinearPolynomial(coefficients.0, coefficients.1)
    }
    
    var shifted: LinearPolynomial<RawValue> {
        return LinearPolynomial(coefficients.1, coefficients.2)
    }
}
