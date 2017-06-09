protocol OneDimensional: Observable, RawValueType {
	// TODO: make Fraction an associated type
    func point(at fraction: RawValue) -> RawPoint<RawValue>?
    func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue?
}
