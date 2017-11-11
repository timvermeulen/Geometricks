protocol ComplexSolvable: Polynomial {
    var complexRoots: [Complex<Input>]? { get }
}

extension ComplexSolvable {
    var realRoots: [Input]? {
        return complexRoots?.flatMap { $0.real }.sorted()
    }
}
