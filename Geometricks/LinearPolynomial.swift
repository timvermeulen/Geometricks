struct LinearPolynomial<RawValue: Real> {
	private let coefficients: (RawValue, RawValue)
	
    init(_ c0: RawValue, _ c1: RawValue) {
		self.coefficients = (c0, c1)
	}
}

extension LinearPolynomial: NonConstantComplexSolvable {
    func evaluated(at x: RawValue) -> RawValue {
        return coefficients.0 + coefficients.1 * x
    }
    
    var leadingCoefficient: RawValue {
        return coefficients.1
    }
    
    var constant: RawValue {
        return coefficients.0
    }
}

extension LinearPolynomial: NonConstantPolynomial {
    var _complexRoots: [Complex<RawValue>]? {
        guard !coefficients.1.isZero else { return popped.complexRoots }
        return [Complex(realPart: -coefficients.0 / coefficients.1)]
    }
    
	var derivative: ConstantPolynomial<RawValue> {
		return ConstantPolynomial(value: coefficients.1)
	}
	
	var popped: ConstantPolynomial<RawValue> {
		return ConstantPolynomial(value: coefficients.0)
	}
    
    var shifted: ConstantPolynomial<RawValue> {
        return ConstantPolynomial(value: coefficients.1)
    }
}
