final class FreePoint<_RawValue: Real> {
	typealias RawValue = _RawValue
	
	private var rawPoint: RawPoint<RawValue> {
		didSet { updateObservers() }
	}
	
	let observableStorage = ObservableStorage()
    
    init(rawPoint: RawPoint<RawValue>) {
        self.rawPoint = rawPoint
    }
	
	convenience init(x: RawValue, y: RawValue) {
		self.init(rawPoint: RawPoint(x: x, y: y))
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
