final class SlidingPoint<RawValue: FloatingPoint> {
    private let oneDimensional: AnyOneDimensional<RawValue>
	
	private var fraction: RawValue {
		didSet { rawPoint = oneDimensional.point(at: fraction) }
	}
	
	var rawPoint: RawPoint<RawValue> {
		didSet { updateObservers() }
	}
	
	let observableStorage = ObservableStorage()
    
    init<T: OneDimensional>(oneDimensional: T, fraction: RawValue) where T.RawValue == RawValue {
        self.oneDimensional = AnyOneDimensional(oneDimensional)
        self.fraction = fraction
		rawPoint = oneDimensional.point(at: fraction)
		
		oneDimensional.keepUpdated(self)
	}
}

extension SlidingPoint: Observer {
	func update() {
		rawPoint = oneDimensional.point(at: fraction)
	}
}

extension SlidingPoint: Drawable {
    func draw(in drawingUnit: AnyDrawingUnit<RawValue>) {
        drawingUnit.drawPoint(at: rawPoint, identifier: identifier)
    }
}

extension SlidingPoint: ConvertibleToRawPoint {
    func makeRawPoint() -> RawPoint<RawValue> {
        return rawPoint
    }
}

extension SlidingPoint: Point {
}

extension SlidingPoint: DraggablePoint {
    func takeOnValue(nearestTo point: RawPoint<RawValue>) {
        fraction = oneDimensional.fractionOfNearestPoint(to: point)
    }
}
