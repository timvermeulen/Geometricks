protocol OneDimensional: Observable, RawValueType {
    func point(at fraction: RawValue) -> RawPoint<RawValue>?
    func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue?
}
