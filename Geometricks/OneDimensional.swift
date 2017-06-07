protocol OneDimensional: Observable {
    associatedtype RawValue: FloatingPoint
    
    func point(at fraction: RawValue) -> RawPoint<RawValue>
    func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue
}
