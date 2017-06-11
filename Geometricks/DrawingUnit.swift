protocol DrawingUnit: RawValueType {
    associatedtype Point: ConvertibleFromRawPoint = RawPoint<RawValue> where Point.RawValue == RawValue
	associatedtype Rect: ConvertibleFromRawRect = RawRect<RawValue> where Rect.RawValue == RawValue
    
    func drawPoint(at location: Point, identifier: Identifier)
	func drawLine(from start: Point, to end: Point, identifier: Identifier)
    func drawCurve(from start: Point, to end: Point, controlPoint1: Point, controlPoint2: Point, identifier: Identifier)
	func drawCircle(center: Point, radius: RawValue, identifier: Identifier)
    func drawCircleCircleIntersectionArea(center0: Point, radius0: RawValue, startAngle0: RawValue, endAngle0: RawValue, center1: Point, radius1: RawValue, startAngle1: RawValue, endAngle1: RawValue, identifier: Identifier)
	
	func drawingWillStart(in rect: Rect?)
    func drawingDidEnd()
}

extension DrawingUnit {
    func drawRawPoint(at location: RawPoint<RawValue>, identifier: Identifier) {
        drawPoint(at: Point(location), identifier: identifier)
    }
	
	func drawRawLine(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>, identifier: Identifier) {
		drawLine(from: Point(start), to: Point(end), identifier: identifier)
	}
    
    func drawRawCurve(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>, controlPoint1: RawPoint<RawValue>, controlPoint2: RawPoint<RawValue>, identifier: Identifier) {
        drawCurve(from: Point(start), to: Point(end), controlPoint1: Point(controlPoint1), controlPoint2: Point(controlPoint2), identifier: identifier)
    }
	
	func drawRawCircle(center: RawPoint<RawValue>, radius: RawValue, identifier: Identifier) {
		drawCircle(center: Point(center), radius: radius, identifier: identifier)
	}
    
    func drawRawCircleCircleIntersectionArea(center0: RawPoint<RawValue>, radius0: RawValue, startAngle0: RawValue, endAngle0: RawValue, center1: RawPoint<RawValue>, radius1: RawValue, startAngle1: RawValue, endAngle1: RawValue, identifier: Identifier) {
        drawCircleCircleIntersectionArea(center0: Point(center0), radius0: radius0, startAngle0: startAngle0, endAngle0: endAngle0, center1: Point(center1), radius1: radius1, startAngle1: startAngle1, endAngle1: endAngle1, identifier: identifier)
    }
	
	func drawingWillStart(in rect: RawRect<RawValue>?) {
		drawingWillStart(in: rect.map(Rect.init))
	}
    
    func drawingDidEnd() {}
}

extension DrawingUnit where Rect == RawRect<RawValue> {
	func drawingWillStart(in rect: RawRect<RawValue>?) {}
}
