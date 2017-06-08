protocol OneDimensional: Observable {
    associatedtype OneDimensionalRawValue: FloatingPoint
    
    func point(at fraction: OneDimensionalRawValue) -> RawPoint<OneDimensionalRawValue>
    func fractionOfNearestPoint(to point: RawPoint<OneDimensionalRawValue>) -> OneDimensionalRawValue
}
