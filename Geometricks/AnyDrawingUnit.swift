struct AnyDrawingUnit<RawValue: FloatingPoint> {
    private let _drawPoint: (RawPoint<RawValue>, Identifier) -> Void
	private let _drawLine: (RawPoint<RawValue>, RawPoint<RawValue>, Identifier) -> Void
    private let _drawCurve: (RawPoint<RawValue>, RawPoint<RawValue>, RawPoint<RawValue>, RawPoint<RawValue>, Identifier) -> Void
	private let _drawCircle: (RawPoint<RawValue>, RawValue, Identifier) -> Void
	private let _drawingWillStart: (RawRect<RawValue>?) -> Void
    private let _drawingDidEnd: () -> Void
    
    init<T: DrawingUnit>(_ drawingUnit: T) where T.RawValue == RawValue {
        _drawPoint = drawingUnit.drawRawPoint
		_drawLine = drawingUnit.drawRawLine
        _drawCurve = drawingUnit.drawRawCurve
		_drawCircle = drawingUnit.drawRawCircle
		_drawingWillStart = drawingUnit.drawingWillStart
        _drawingDidEnd = drawingUnit.drawingDidEnd
    }
    
    func drawPoint<P: ConvertibleToRawPoint>(at location: P, identifier: Identifier) where P.RawValue == RawValue {
		guard let rawPoint = location.makeRawPoint() else { return }
        _drawPoint(rawPoint, identifier)
    }
	
	func drawLine<P1: ConvertibleToRawPoint, P2: ConvertibleToRawPoint>(from start: P1, to end: P2, identifier: Identifier) where P1.RawValue == RawValue, P2.RawValue == RawValue {
		guard let rawStart = start.makeRawPoint(), let rawEnd = end.makeRawPoint() else { return }
		_drawLine(rawStart, rawEnd, identifier)
	}
    
    func drawCurve<P1: ConvertibleToRawPoint, P2: ConvertibleToRawPoint, P3: ConvertibleToRawPoint, P4: ConvertibleToRawPoint>(from start: P1, to end: P2, controlPoint1: P3, controlPoint2: P4, identifier: Identifier) where P1.RawValue == RawValue, P2.RawValue == RawValue, P3.RawValue == RawValue, P4.RawValue == RawValue {
		guard
			let rawStart = start.makeRawPoint(),
			let rawEnd = end.makeRawPoint(),
			let rawControlPoint1 = controlPoint1.makeRawPoint(),
			let rawControlPoint2 = controlPoint2.makeRawPoint()
			else { return }
		
        _drawCurve(rawStart, rawEnd, rawControlPoint1, rawControlPoint2, identifier)
    }
	
	func drawCircle<P: ConvertibleToRawPoint>(center: P, radius: RawValue, identifier: Identifier) where P.RawValue == RawValue {
		guard let rawCenter = center.makeRawPoint() else { return }
		_drawCircle(rawCenter, radius, identifier)
	}
	
	func drawingWillStart<T: ConvertibleToRawRect>(in rect: T?) where T.RawValue == RawValue {
		_drawingWillStart(rect?.makeRawRect())
	}
    
    func drawingDidEnd() {
        _drawingDidEnd()
    }
}
