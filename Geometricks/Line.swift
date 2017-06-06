final class Line<RawValue: FloatingPoint> {
    let start: AnyPoint<RawValue>
    let end: AnyPoint<RawValue>
    
    init(from start: AnyPoint<RawValue>, to end: AnyPoint<RawValue>) {
        self.start = start
        self.end = end
    }
    
    init<P1: Point, P2: Point>(from start: P1, to end: P2) where P1.RawValue == RawValue, P2.RawValue == RawValue {
        self.start = AnyPoint(start)
        self.end = AnyPoint(end)
    }
}

extension Line: Drawable {
    func draw(in drawingUnit: AnyDrawingUnit<RawValue>) {
        drawingUnit.drawLine(from: start, to: end, identifier: ObjectIdentifier(self))
        
        start.draw(in: drawingUnit)
        end.draw(in: drawingUnit)
    }
}
