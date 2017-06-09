struct AnyDraggablePoint<_RawValue: FloatingPoint> {
	typealias RawValue = _RawValue
	
    private let _takeOnValue: (RawPoint<RawValue>) -> Void
    private let _draw: (RawRect<RawValue>, AnyDrawingUnit<RawValue>) -> Void
    private let _makeRawPoint: () -> RawPoint<RawValue>
    
    let identifier: Identifier
	let observableStorage: ObservableStorage
    
    init<T: DraggablePoint>(_ draggable: T) where T.RawValue == RawValue {
        _takeOnValue = draggable.takeOnValue
        _draw = draggable.draw
        _makeRawPoint = draggable.makeRawPoint
        
        identifier = draggable.identifier
		observableStorage = draggable.observableStorage
    }
}

extension AnyDraggablePoint: DraggablePoint {
    func draw(in rect: RawRect<RawValue>, using drawingUnit: AnyDrawingUnit<RawValue>) {
        _draw(rect, drawingUnit)
    }
    
    func makeRawPoint() -> RawPoint<RawValue> {
        return _makeRawPoint()
    }
    
    func takeOnValue(nearestTo point: RawPoint<RawValue>) {
        _takeOnValue(point)
    }
}
