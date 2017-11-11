struct QuarticPolynomial<RawValue: Real> {
    private let coefficients: (RawValue, RawValue, RawValue, RawValue, RawValue)
    
    init(_ c0: RawValue, _ c1: RawValue, _ c2: RawValue, _ c3: RawValue, _ c4: RawValue) {
        coefficients = (c0, c1, c2, c3, c4)
    }
}

extension QuarticPolynomial: Polynomial {
    var leadingCoefficient: RawValue {
        return coefficients.4
    }
    
    var constant: RawValue {
        return coefficients.0
    }
    
    func evaluated(at x: RawValue) -> RawValue {
        let x2 = x * x
        let x3 = x * x2
        let x4 = x * x3
        
        let t0 = coefficients.0
        let t1 = coefficients.1 * x
        let t2 = coefficients.2 * x2
        let t3 = coefficients.3 * x3
        let t4 = coefficients.4 * x4
        
        return t0 + t1 + t2 + t3 + t4
    }
}

extension QuarticPolynomial: NonConstantPolynomial {
    var derivative: CubicPolynomial<RawValue> {
        return CubicPolynomial(coefficients.1, 2 * coefficients.2, 3 * coefficients.3, 4 * coefficients.4)
    }
    
    var popped: CubicPolynomial<RawValue> {
        return CubicPolynomial(coefficients.0, coefficients.1, coefficients.2, coefficients.3)
    }
    
    var shifted: CubicPolynomial<RawValue> {
        return CubicPolynomial(coefficients.1, coefficients.2, coefficients.3, coefficients.4)
    }
}
