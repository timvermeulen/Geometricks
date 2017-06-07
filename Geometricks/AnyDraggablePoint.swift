struct AnyDraggablePoint<RawValue: FloatingPoint> {
    private let _takeOnValue: (RawPoint<RawValue>) -> Void
    private let _draw: (AnyDrawingUnit<RawValue>) -> Void
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
    func draw(in drawingUnit: AnyDrawingUnit<RawValue>) {
        _draw(drawingUnit)
    }
    
    func makeRawPoint() -> RawPoint<RawValue> {
        return _makeRawPoint()
    }
    
    func takeOnValue(nearestTo point: RawPoint<RawValue>) {
        _takeOnValue(point)
    }
}
