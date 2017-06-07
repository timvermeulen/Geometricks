final class Curve<RawValue: FloatingPoint> {
    let start: AnyPoint<RawValue>
    let end: AnyPoint<RawValue>
    let controlPoint1: AnyPoint<RawValue>
    let controlPoint2: AnyPoint<RawValue>
    
    init(from start: AnyPoint<RawValue>, to end: AnyPoint<RawValue>, controlPoint1: AnyPoint<RawValue>, controlPoint2: AnyPoint<RawValue>) {
        self.start = start
        self.end = end
        self.controlPoint1 = controlPoint1
        self.controlPoint2 = controlPoint2
    }
    
    init<P1: Point, P2: Point, P3: Point, P4: Point>(from start: P1, to end: P2, controlPoint1: P3, controlPoint2: P4) where P1.RawValue == RawValue, P2.RawValue == RawValue, P3.RawValue == RawValue, P4.RawValue == RawValue {
        self.start = AnyPoint(start)
        self.end = AnyPoint(end)
        self.controlPoint1 = AnyPoint(controlPoint1)
        self.controlPoint2 = AnyPoint(controlPoint2)
    }
}

extension Curve: Drawable {
    func draw(in drawingUnit: AnyDrawingUnit<RawValue>) {
        drawingUnit.drawCurve(from: start, to: end, controlPoint1: controlPoint1, controlPoint2: controlPoint2, identifier: identifier)
        
        start.draw(in: drawingUnit)
        end.draw(in: drawingUnit)
        controlPoint1.draw(in: drawingUnit)
        controlPoint2.draw(in: drawingUnit)
    }
}

extension Curve: OneDimensional {
    func point(at fraction: RawValue) -> RawPoint<RawValue> {
        fatalError()
    }
    
    func nearestPoint(to point: RawPoint<RawValue>) -> RawPoint<RawValue> {
        fatalError()
    }
}
