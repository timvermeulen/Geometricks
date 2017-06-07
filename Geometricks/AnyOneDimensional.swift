struct AnyOneDimensional<RawValue: FloatingPoint> {
    private let _point: (RawValue) -> RawPoint<RawValue>
    private let _fractionOfNearestPoint: (RawPoint<RawValue>) -> RawValue
	
	let observableStorage: ObservableStorage
    
    init<T: OneDimensional>(_ oneDimensional: T) where T.RawValue == RawValue {
        _point = oneDimensional.point
        _fractionOfNearestPoint = oneDimensional.fractionOfNearestPoint
		
		observableStorage = oneDimensional.observableStorage
    }
}

extension AnyOneDimensional: OneDimensional {
    func point(at fraction: RawValue) -> RawPoint<RawValue> {
        return _point(fraction)
    }
    
    func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue {
        return _fractionOfNearestPoint(point)
    }
}
