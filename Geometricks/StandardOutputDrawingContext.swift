final class StandardOutputDrawingContext<Raw: FloatingPoint>: DrawingContext {
    typealias RawValue = Raw
    
    func drawPoint(at location: RawPoint<RawValue>) {
        print("draw point at \(location)")
    }
    
    func drawLine(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>) {
        print("draw line from \(start) to \(end)")
    }
    
    func drawCurve(from start: RawPoint<Raw>, to end: RawPoint<Raw>, controlPoint1: RawPoint<Raw>, controlPoint2: RawPoint<Raw>) {
        print("draw curve from \(start) to \(end) with control points \(controlPoint1) and \(controlPoint2)")
    }
}
