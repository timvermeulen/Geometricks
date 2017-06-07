struct AnyPoint<RawValue: FloatingPoint> {
    private let _draw: (AnyDrawingUnit<RawValue>) -> Void
    private let _makeRawPoint: () -> RawPoint<RawValue>
    
    let identifier: Identifier
    
    init<P: Point>(_ point: P) where P.RawValue == RawValue {
        _draw = point.draw
        _makeRawPoint = point.makeRawPoint
        
        identifier = point.identifier
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
