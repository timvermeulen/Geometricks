protocol DrawingUnit {
    associatedtype RawValue
    associatedtype RawPoint: ConvertibleFromRawPoint where RawPoint.RawValue == RawValue
    
    func drawPoint(at location: RawPoint, identifier: ObjectIdentifier)
    func drawLine(from start: RawPoint, to end: RawPoint, identifier: ObjectIdentifier)
    func drawCurve(from start: RawPoint, to end: RawPoint, controlPoint1: RawPoint, controlPoint2: RawPoint, identifier: ObjectIdentifier)
    
    func drawingDidEnd()
}

extension DrawingUnit {
    func drawingDidEnd() {}
}
