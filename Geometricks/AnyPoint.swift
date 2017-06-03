struct AnyPoint<RawValue: FloatingPoint> {
    private let _draw: (AnyDrawingContext<RawValue>) -> Void
    private let _makeRawPoint: () -> RawPoint<RawValue>
    
    let identifier: ObjectIdentifier
    
    init<P: Point>(_ point: P) where P.RawValue == RawValue {
        _draw = point.draw
        _makeRawPoint = point.makeRawPoint
        
        identifier = ObjectIdentifier(point)
    }
}

extension AnyPoint: Drawable {
    func draw(in context: AnyDrawingContext<RawValue>) {
        _draw(context)
    }
}

extension AnyPoint: ConvertibleToRawPoint {
    func makeRawPoint() -> RawPoint<RawValue> {
        return _makeRawPoint()
    }
}
