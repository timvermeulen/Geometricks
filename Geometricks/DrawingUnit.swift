protocol DrawingUnit {
    associatedtype DrawingUnitRawValue
    associatedtype Point: ConvertibleFromRawPoint where Point.ConvertibleFromRawPointRawValue == DrawingUnitRawValue
    
    func drawPoint(at location: Point, identifier: Identifier)
    func drawLineSegment(from start: Point, to end: Point, identifier: Identifier)
    func drawCurve(from start: Point, to end: Point, controlPoint1: Point, controlPoint2: Point, identifier: Identifier)
	func drawCircle(center: Point, radius: DrawingUnitRawValue, identifier: Identifier)
    
    func drawingDidEnd()
}

extension DrawingUnit {
    func drawPoint(at location: RawPoint<DrawingUnitRawValue>, identifier: Identifier) {
        drawPoint(at: Point(location), identifier: identifier)
    }
    
    func drawLineSegment(from start: RawPoint<DrawingUnitRawValue>, to end: RawPoint<DrawingUnitRawValue>, identifier: Identifier) {
        drawLineSegment(from: Point(start), to: Point(end), identifier: identifier)
    }
    
    func drawCurve(from start: RawPoint<DrawingUnitRawValue>, to end: RawPoint<DrawingUnitRawValue>, controlPoint1: RawPoint<DrawingUnitRawValue>, controlPoint2: RawPoint<DrawingUnitRawValue>, identifier: Identifier) {
        drawCurve(from: Point(start), to: Point(end), controlPoint1: Point(controlPoint1), controlPoint2: Point(controlPoint2), identifier: identifier)
    }
	
	func drawCircle(center: RawPoint<DrawingUnitRawValue>, radius: DrawingUnitRawValue, identifier: Identifier) {
		drawCircle(center: Point(center), radius: radius, identifier: identifier)
	}
    
    func drawingDidEnd() {}
}
