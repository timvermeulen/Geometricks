struct AnyDrawingUnit<RawValue: FloatingPoint> {
    private let _drawPoint: (RawPoint<RawValue>, Identifier) -> Void
    private let _drawLine: (RawPoint<RawValue>, RawPoint<RawValue>, Identifier) -> Void
    private let _drawCurve: (RawPoint<RawValue>, RawPoint<RawValue>, RawPoint<RawValue>, RawPoint<RawValue>, Identifier) -> Void
    private let _drawingDidEnd: () -> Void
    
    init<T: DrawingUnit>(_ drawingUnit: T) where T.RawValue == RawValue {
        _drawPoint = { point, identifier in drawingUnit.drawPoint(at: point, identifier: identifier) }
        _drawLine = { start, end, identifier in drawingUnit.drawLine(from: start, to: end, identifier: identifier) }
        _drawCurve = { start, end, control1, control2, identifier in drawingUnit.drawCurve(from: start, to: end, controlPoint1: control1, controlPoint2: control2, identifier: identifier) }
        _drawingDidEnd = drawingUnit.drawingDidEnd
    }
    
    func drawPoint<P: ConvertibleToRawPoint>(at location: P, identifier: Identifier) where P.RawValue == RawValue {
        _drawPoint(location.makeRawPoint(), identifier)
    }
    
    func drawLine<P1: ConvertibleToRawPoint, P2: ConvertibleToRawPoint>(from start: P1, to end: P2, identifier: Identifier) where P1.RawValue == RawValue, P2.RawValue == RawValue {
        _drawLine(start.makeRawPoint(), end.makeRawPoint(), identifier)
    }
    
    func drawCurve<P1: ConvertibleToRawPoint, P2: ConvertibleToRawPoint, P3: ConvertibleToRawPoint, P4: ConvertibleToRawPoint>(from start: P1, to end: P2, controlPoint1: P3, controlPoint2: P4, identifier: Identifier) where P1.RawValue == RawValue, P2.RawValue == RawValue, P3.RawValue == RawValue, P4.RawValue == RawValue {
        _drawCurve(start.makeRawPoint(), end.makeRawPoint(), controlPoint1.makeRawPoint(), controlPoint2.makeRawPoint(), identifier)
    }
    
    func drawingDidEnd() {
        _drawingDidEnd()
    }
}
