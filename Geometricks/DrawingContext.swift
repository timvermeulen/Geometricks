protocol DrawingContext {
    associatedtype RawValue
    associatedtype RawPoint: ConvertibleFromRawPoint where RawPoint.RawValue == RawValue
    
    func drawPoint(at location: RawPoint)
    func drawLine(from start: RawPoint, to end: RawPoint)
    func drawCurve(from start: RawPoint, to end: RawPoint, controlPoint1: RawPoint, controlPoint2: RawPoint)
}
