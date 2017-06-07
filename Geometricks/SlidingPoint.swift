final class SlidingPoint<RawValue: FloatingPoint> {
    let oneDimensional: AnyOneDimensional<RawValue>
    var fraction: RawValue
    var rawPoint: RawPoint<RawValue>
    
    init<T: OneDimensional>(oneDimensional: T, fraction: RawValue) where T.RawValue == RawValue {
        self.oneDimensional = AnyOneDimensional(oneDimensional)
        self.fraction = fraction
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
        rawPoint = oneDimensional.nearestPoint(to: point)
    }
}
