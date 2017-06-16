protocol OneDimensional: Observable {
    associatedtype RawValue: Real
    
    func point(at fraction: RawValue) -> RawPoint<RawValue>?
    func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue?
}
