struct AnyOneDimensional<RawValue: FloatingPoint> {
    private let _point: (RawValue) -> RawPoint<RawValue>
    private let _nearestPoint: (RawPoint<RawValue>) -> RawPoint<RawValue>
    
    init<T: OneDimensional>(_ oneDimensional: T) where T.RawValue == RawValue {
        _point = oneDimensional.point
        _nearestPoint = oneDimensional.nearestPoint
    }
}

extension AnyOneDimensional: OneDimensional {
    func point(at fraction: RawValue) -> RawPoint<RawValue> {
        return _point(fraction)
    }
    
    func nearestPoint(to point: RawPoint<RawValue>) -> RawPoint<RawValue> {
        return _nearestPoint(point)
    }
}
