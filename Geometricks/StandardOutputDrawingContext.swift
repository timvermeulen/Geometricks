final class StandardOutputDrawingContext<Raw: FloatingPoint>: DrawingContext {
    typealias RawValue = Raw
    
    func drawPoint(at location: RawPoint<RawValue>) {
        print("draw point at \(location)")
    }
    
    func drawLine(from start: RawPoint<RawValue>, to end: RawPoint<RawValue>) {
        print("draw line from \(start) to \(end)")
    }
}
