struct AnyDrawingContext<RawValue: FloatingPoint> {
    private let _drawPoint: (RawPoint<RawValue>) -> Void
    private let _drawLine: (RawPoint<RawValue>, RawPoint<RawValue>) -> Void
    
    func drawPoint<Point: ConvertibleToRawPoint>(at location: Point) where Point.RawValue == RawValue {
        _drawPoint(location.makeRawPoint())
    }
    
    func drawLine<Point: ConvertibleToRawPoint>(from start: Point, to end: Point) where Point.RawValue == RawValue {
        _drawLine(start.makeRawPoint(), end.makeRawPoint())
    }
    
    init<Context: DrawingContext>(_ context: Context) where Context.RawPoint.RawValue == RawValue {
        _drawPoint = { point in context.drawPoint(at: Context.RawPoint(point)) }
        _drawLine = { start, end in context.drawLine(from: Context.RawPoint(start), to: Context.RawPoint(end)) }
    }
}
