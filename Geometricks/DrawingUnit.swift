protocol DrawingUnit {
    associatedtype RawValue
    associatedtype Point: ConvertibleFromRawPoint where Point.RawValue == RawValue
    
    func drawPoint(at location: Point, identifier: Identifier)
    func drawLineSegment(from start: Point, to end: Point, identifier: Identifier)
    func drawCurve(from start: Point, to end: Point, controlPoint1: Point, controlPoint2: Point, identifier: Identifier)
    
    func drawingDidEnd()
}

extension DrawingUnit {
    func drawPoint(at location: RawPoint<RawValue>, identifier: Identifier) {
        drawPoint(at: Point(location), identifier: identifier)
    }
    
    func drawLineSegment(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>, identifier: Identifier) {
        drawLineSegment(from: Point(start), to: Point(end), identifier: identifier)
    }
    
    func drawCurve(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>, controlPoint1: RawPoint<RawValue>, controlPoint2: RawPoint<RawValue>, identifier: Identifier) {
        drawCurve(from: Point(start), to: Point(end), controlPoint1: Point(controlPoint1), controlPoint2: Point(controlPoint2), identifier: identifier)
    }
    
    func drawingDidEnd() {}
}
