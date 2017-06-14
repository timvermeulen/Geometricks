struct QuinticPolynomial<RawValue: Real> {
    private let coefficients: (RawValue, RawValue, RawValue, RawValue, RawValue, RawValue)
    
    init(_ c0: RawValue, _ c1: RawValue, _ c2: RawValue, _ c3: RawValue, _ c4: RawValue, _ c5: RawValue) {
        coefficients = (c0, c1, c2, c3, c4, c5)
    }
}

extension QuinticPolynomial: Polynomial {
    var leadingCoefficient: RawValue {
        return coefficients.5
    }
    
    var constant: RawValue {
        return coefficients.0
    }
    
    func evaluated(at x: RawValue) -> RawValue {
        let x2 = x * x
        let x3 = x * x2
        let x4 = x * x3
        let x5 = x * x4
        
        let t0 = coefficients.0
        let t1 = coefficients.1 * x
        let t2 = coefficients.2 * x2
        let t3 = coefficients.3 * x3
        let t4 = coefficients.4 * x4
        let t5 = coefficients.5 * x5
        
        return t0 + t1 + t2 + t3 + t4 + t5
    }
}

extension QuinticPolynomial: NonConstantPolynomial {
    var derivative: QuarticPolynomial<RawValue> {
        return QuarticPolynomial(coefficients.1, 2 * coefficients.2, 3 * coefficients.3, 4 * coefficients.4, 5 * coefficients.5)
    }
    
    var popped: QuarticPolynomial<RawValue> {
        return QuarticPolynomial(coefficients.0, coefficients.1, coefficients.2, coefficients.3, coefficients.4)
    }
    
    var shifted: QuarticPolynomial<RawValue> {
        return QuarticPolynomial(coefficients.1, coefficients.2, coefficients.3, coefficients.4, coefficients.5)
    }
}

