protocol FreeValued {
    associatedtype RawValue: FloatingPoint
    
    func isAtPoint(_ point: RawPoint<RawValue>) -> Bool
    func takeOnValue(nearestTo point: RawPoint<RawValue>)
}
