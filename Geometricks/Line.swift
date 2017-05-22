final class Line<RawValue: FloatingPoint> {
    var start: AnyPoint<RawValue>
    var end: AnyPoint<RawValue>
    
    init(start: AnyPoint<RawValue>, end: AnyPoint<RawValue>) {
        self.start = start
        self.end = end
    }
    
    init<P1: Point, P2: Point>(start: P1, end: P2) where P1.RawValue == RawValue, P2.RawValue == RawValue {
        self.start = AnyPoint(start)
        self.end = AnyPoint(end)
    }
}

extension Line: Drawable {
    func draw(in context: AnyDrawingContext<RawValue>) {
        context.drawLine(from: start, to: end)
        
        start.draw(in: context)
        end.draw(in: context)
    }
}
