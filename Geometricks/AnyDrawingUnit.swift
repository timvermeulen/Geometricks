struct AnyDrawingUnit<RawValue: FloatingPoint> {
    private let _drawPoint: (RawPoint<RawValue>, Identifier) -> Void
	private let _drawLine: (RawPoint<RawValue>, RawPoint<RawValue>, Identifier) -> Void
    private let _drawCurve: (RawPoint<RawValue>, RawPoint<RawValue>, RawPoint<RawValue>, RawPoint<RawValue>, Identifier) -> Void
	private let _drawCircle: (RawPoint<RawValue>, RawValue, Identifier) -> Void
	private let _drawingWillStart: (RawRect<RawValue>) -> Void
    private let _drawingDidEnd: () -> Void
    
    init<T: DrawingUnit>(_ drawingUnit: T) where T.RawValue == RawValue {
        _drawPoint = drawingUnit.drawPoint
		_drawLine = drawingUnit.drawLine
        _drawCurve = drawingUnit.drawCurve
		_drawCircle = drawingUnit.drawCircle
		_drawingWillStart = drawingUnit.drawingWillStart
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
	
	func drawCircle<P: ConvertibleToRawPoint>(center: P, radius: RawValue, identifier: Identifier) where P.RawValue == RawValue {
		_drawCircle(center.makeRawPoint(), radius, identifier)
	}
	
	func drawingWillStart<T: ConvertibleToRawRect>(in rect: T) where T.RawValue == RawValue {
		_drawingWillStart(rect.makeRawRect())
	}
    
    func drawingDidEnd() {
        _drawingDidEnd()
    }
}
