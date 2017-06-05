struct AnyDrawingUnit<RawValue: FloatingPoint> {
    typealias Point = RawPoint<RawValue>
    
    private let _drawPoint: (Point, ObjectIdentifier) -> Void
    private let _drawLine: (Point, Point, ObjectIdentifier) -> Void
    private let _drawCurve: (Point, Point, Point, Point, ObjectIdentifier) -> Void
    private let _drawingDidEnd: () -> Void
    
    init<Context: DrawingUnit>(_ context: Context) where Context.RawPoint.RawValue == RawValue {
        _drawPoint = { point, identifier in context.drawPoint(at: Context.RawPoint(point), identifier: identifier) }
        _drawLine = { start, end, identifier in context.drawLine(from: Context.RawPoint(start), to: Context.RawPoint(end), identifier: identifier) }
        _drawCurve = { start, end, control1, control2, identifier in context.drawCurve(from: Context.RawPoint(start), to: Context.RawPoint(end), controlPoint1: Context.RawPoint(control1), controlPoint2: Context.RawPoint(control2), identifier: identifier) }
        _drawingDidEnd = context.drawingDidEnd
    }
    
    func drawPoint<P: ConvertibleToRawPoint>(at location: P, identifier: ObjectIdentifier) where P.RawValue == RawValue {
        _drawPoint(location.makeRawPoint(), identifier)
    }
    
    func drawLine<P1: ConvertibleToRawPoint, P2: ConvertibleToRawPoint>(from start: P1, to end: P2, identifier: ObjectIdentifier) where P1.RawValue == RawValue, P2.RawValue == RawValue {
        _drawLine(start.makeRawPoint(), end.makeRawPoint(), identifier)
    }
    
    func drawCurve<P1: ConvertibleToRawPoint, P2: ConvertibleToRawPoint, P3: ConvertibleToRawPoint, P4: ConvertibleToRawPoint>(from start: P1, to end: P2, controlPoint1: P3, controlPoint2: P4, identifier: ObjectIdentifier) where P1.RawValue == RawValue, P2.RawValue == RawValue, P3.RawValue == RawValue, P4.RawValue == RawValue {
        _drawCurve(start.makeRawPoint(), end.makeRawPoint(), controlPoint1.makeRawPoint(), controlPoint2.makeRawPoint(), identifier)
    }
    
    func drawingDidEnd() {
        _drawingDidEnd()
    }
}
