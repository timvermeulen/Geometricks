final class FreePoint<_RawValue: FloatingPoint> {
	typealias RawValue = _RawValue
	
	private var rawPoint: RawPoint<RawValue> {
		didSet { updateObservers() }
	}
	
	let observableStorage = ObservableStorage()
    
    init(rawPoint: RawPoint<RawValue>) {
        self.rawPoint = rawPoint
    }
}

extension FreePoint: AlwaysConvertibleToRawPoint {
    func makeRawPoint() -> RawPoint<RawValue> {
        return rawPoint
    }
}

extension FreePoint: DraggablePoint {
    func takeOnValue(nearestTo point: RawPoint<RawValue>) {
        rawPoint = point
    }
}
