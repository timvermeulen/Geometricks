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

extension FreePoint: Drawable {
    func draw(in drawingUnit: AnyDrawingUnit<RawValue>) {
        drawingUnit.drawPoint(at: rawPoint, identifier: identifier)
    }
}

extension FreePoint: ConvertibleToRawPoint {
    func makeRawPoint() -> RawPoint<RawValue> {
        return rawPoint
    }
}

extension FreePoint: Point {
}

extension FreePoint: DraggablePoint {
    func takeOnValue(nearestTo point: RawPoint<RawValue>) {
        rawPoint = point
    }
}
