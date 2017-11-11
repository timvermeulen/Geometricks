struct ConstantPolynomial<RawValue: Real> {
    private let value: RawValue
    
    init(value: RawValue) {
        self.value = value
    }
}

extension ConstantPolynomial: TextOutputStreamable {
    func write<Target: TextOutputStream>(to target: inout Target) {
        target.write(String(describing: value))
    }
}

extension ConstantPolynomial: ComplexSolvable {
    static var degree: Int {
        return 0
    }
    
    func evaluated(at x: RawValue) -> RawValue {
        return value
    }
    
    var complexRoots: [Complex<RawValue>]? {
        return value.isZero ? nil : []
    }
    
    var realRoots: [RawValue]? {
        return value.isZero ? nil : []
    }
    
    var leadingCoefficient: RawValue {
        return value
    }
    
    var constant: RawValue {
        return value
    }
}
