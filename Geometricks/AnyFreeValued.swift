struct AnyFreeValued<RawValue: FloatingPoint> {
    private let _isAtPoint: (RawPoint<RawValue>) -> Bool
    private let _takeOnValue: (RawPoint<RawValue>) -> Void
    
    init<T: FreeValued>(_ freeValued: T) where T.RawValue == RawValue {
        _isAtPoint = freeValued.isAtPoint
        _takeOnValue = freeValued.takeOnValue
    }
    
    func isAtPoint(_ point: RawPoint<RawValue>) -> Bool {
        return _isAtPoint(point)
    }
    
    func takeOnValue(nearestTo point: RawPoint<RawValue>) {
        _takeOnValue(point)
    }
}
