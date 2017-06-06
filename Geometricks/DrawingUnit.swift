protocol DrawingUnit {
    associatedtype RawValue
    associatedtype Point: ConvertibleFromRawPoint where Point.RawValue == RawValue
    
    func drawPoint(at location: Point, identifier: ObjectIdentifier)
    func drawLine(from start: Point, to end: Point, identifier: ObjectIdentifier)
    func drawCurve(from start: Point, to end: Point, controlPoint1: Point, controlPoint2: Point, identifier: ObjectIdentifier)
    
    func drawingDidEnd()
}

extension DrawingUnit {
    func drawPoint(at location: RawPoint<RawValue>, identifier: ObjectIdentifier) {
        drawPoint(at: Point(location), identifier: identifier)
    }
    
    func drawLine(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>, identifier: ObjectIdentifier) {
        drawLine(from: Point(start), to: Point(end), identifier: identifier)
    }
    
    func drawCurve(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>, controlPoint1: RawPoint<RawValue>, controlPoint2: RawPoint<RawValue>, identifier: ObjectIdentifier) {
        drawCurve(from: Point(start), to: Point(end), controlPoint1: Point(controlPoint1), controlPoint2: Point(controlPoint2), identifier: identifier)
    }
    
    func drawingDidEnd() {}
}
