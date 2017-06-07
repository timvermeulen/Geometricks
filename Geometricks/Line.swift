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
        drawingUnit.drawLine(from: start, to: end, identifier: identifier)
        
        start.draw(in: drawingUnit)
        end.draw(in: drawingUnit)
    }
}

extension Line: OneDimensional {
    func point(at fraction: RawValue) -> RawPoint<RawValue> {
        let rawStart = start.makeRawPoint()
        let rawEnd = end.makeRawPoint()
        
        return rawStart + fraction * (rawEnd - rawStart)
    }
    
    func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue {
		let fraction = RawPoint.fractionOfProjection(of: point, onLineBetween: start.makeRawPoint(), and: end.makeRawPoint())
		return max(0, min(1, fraction))
    }
}
