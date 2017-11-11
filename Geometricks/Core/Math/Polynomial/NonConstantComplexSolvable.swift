protocol NonConstantComplexSolvable: ComplexSolvable, NonConstantPolynomial where Derivative: ComplexSolvable {
    var _complexRoots: [Complex<Input>]? { get }
}

extension NonConstantComplexSolvable {
    var complexRoots: [Complex<Input>]? {
        guard !leadingCoefficient.isZero else {
            return popped.complexRoots
        }
        
        guard !constant.isZero else {
            return shifted.complexRoots.map { $0 + [0 + 0 * .i] }
        }
        
        return _complexRoots
    }
    
    var realRoots: [Input]? {
        return complexRoots?.flatMap { $0.real }.sorted()
    }
}
