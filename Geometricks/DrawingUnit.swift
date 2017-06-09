protocol DrawingUnit: RawValueType {
    associatedtype Point: ConvertibleFromRawPoint where Point.RawValue == RawValue
	associatedtype Rect: ConvertibleFromRawRect = RawRect<RawValue> where Rect.RawValue == RawValue
    
    func drawPoint(at location: Point, identifier: Identifier)
	func drawLine(from start: Point, to end: Point, identifier: Identifier)
    func drawCurve(from start: Point, to end: Point, controlPoint1: Point, controlPoint2: Point, identifier: Identifier)
	func drawCircle(center: Point, radius: RawValue, identifier: Identifier)
	
	func drawingWillStart(in rect: Rect)
    func drawingDidEnd()
}

extension DrawingUnit {
    func drawPoint(at location: RawPoint<RawValue>, identifier: Identifier) {
        drawPoint(at: Point(location), identifier: identifier)
    }
	
	func drawLine(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>, identifier: Identifier) {
		drawLine(from: Point(start), to: Point(end), identifier: identifier)
	}
    
    func drawCurve(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>, controlPoint1: RawPoint<RawValue>, controlPoint2: RawPoint<RawValue>, identifier: Identifier) {
        drawCurve(from: Point(start), to: Point(end), controlPoint1: Point(controlPoint1), controlPoint2: Point(controlPoint2), identifier: identifier)
    }
	
	func drawCircle(center: RawPoint<RawValue>, radius: RawValue, identifier: Identifier) {
		drawCircle(center: Point(center), radius: radius, identifier: identifier)
	}
	
	func drawingWillStart(in rect: RawRect<RawValue>) {
		drawingWillStart(in: Rect(rect))
	}
    
    func drawingDidEnd() {}
}

extension DrawingUnit where Rect == RawRect<RawValue> {
	func drawingWillStart(in rect: RawRect<RawValue>) {}
}
