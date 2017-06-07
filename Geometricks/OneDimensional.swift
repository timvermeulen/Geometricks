protocol OneDimensional {
    associatedtype RawValue: FloatingPoint
    
    func point(at fraction: RawValue) -> RawPoint<RawValue>
    func nearestPoint(to point: RawPoint<RawValue>) -> RawPoint<RawValue>
}
