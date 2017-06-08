struct AnyPoint<_RawValue: FloatingPoint> {
	typealias RawValue = _RawValue
	
    private let _draw: (AnyDrawingUnit<RawValue>) -> Void
    private let _makeRawPoint: () -> RawPoint<RawValue>
    
    let identifier: Identifier
	let observableStorage: ObservableStorage
    
    init<P: Point>(_ point: P) where P.RawValue == RawValue {
        _draw = point.draw
        _makeRawPoint = point.makeRawPoint
        
        identifier = point.identifier
		observableStorage = point.observableStorage
    }
}

extension AnyPoint: Drawable {
    func draw(in drawingUnit: AnyDrawingUnit<RawValue>) {
        _draw(drawingUnit)
    }
}

extension AnyPoint: ConvertibleToRawPoint {
    func makeRawPoint() -> RawPoint<RawValue> {
        return _makeRawPoint()
    }
}

extension AnyPoint: Point {
}
