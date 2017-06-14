struct AnyPoint<_RawValue: Real> {
	typealias RawValue = _RawValue
	
    private let _draw: (RawRect<RawValue>, AnyDrawingUnit<RawValue>) -> Void
    private let _makeRawPoint: () -> RawPoint<RawValue>?
    
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
    func draw(in rect: RawRect<RawValue>, using drawingUnit: AnyDrawingUnit<RawValue>) {
        _draw(rect, drawingUnit)
    }
}

extension AnyPoint: ConvertibleToRawPoint {
    func makeRawPoint() -> RawPoint<RawValue>? {
        return _makeRawPoint()
    }
}

extension AnyPoint: Point {
}
