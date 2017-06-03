struct AnyDrawingContext<RawValue: FloatingPoint> {
    typealias Point = RawPoint<RawValue>
    
    private let _drawPoint: (Point, ObjectIdentifier) -> Void
    private let _drawLine: (Point, Point) -> Void
    private let _drawCurve: (Point, Point, Point, Point) -> Void
    private let _drawingDidEnd: () -> Void
    
    init<Context: DrawingContext>(_ context: Context) where Context.RawPoint.RawValue == RawValue {
        _drawPoint = { point, identifier in context.drawPoint(at: Context.RawPoint(point), identifier: identifier) }
        _drawLine = { start, end in context.drawLine(from: Context.RawPoint(start), to: Context.RawPoint(end)) }
        _drawCurve = { start, end, control1, control2 in context.drawCurve(from: Context.RawPoint(start), to: Context.RawPoint(end), controlPoint1: Context.RawPoint(control1), controlPoint2: Context.RawPoint(control2)) }
        _drawingDidEnd = context.drawingDidEnd
    }
    
    func drawPoint<P: ConvertibleToRawPoint>(at location: P, identifier: ObjectIdentifier) where P.RawValue == RawValue {
        _drawPoint(location.makeRawPoint(), identifier)
    }
    
    func drawLine<P1: ConvertibleToRawPoint, P2: ConvertibleToRawPoint>(from start: P1, to end: P2) where P1.RawValue == RawValue, P2.RawValue == RawValue {
        _drawLine(start.makeRawPoint(), end.makeRawPoint())
    }
    
    func drawCurve<P1: ConvertibleToRawPoint, P2: ConvertibleToRawPoint, P3: ConvertibleToRawPoint, P4: ConvertibleToRawPoint>(from start: P1, to end: P2, controlPoint1: P3, controlPoint2: P4) where P1.RawValue == RawValue, P2.RawValue == RawValue, P3.RawValue == RawValue, P4.RawValue == RawValue {
        _drawCurve(start.makeRawPoint(), end.makeRawPoint(), controlPoint1.makeRawPoint(), controlPoint2.makeRawPoint())
    }
    
    func drawingDidEnd() {
        _drawingDidEnd()
    }
}
