final class LineSegment<RawValue: FloatingPoint> {
    private let start: AnyPoint<RawValue>
    private let end: AnyPoint<RawValue>
	
	let observableStorage = ObservableStorage()
    
    init(from start: AnyPoint<RawValue>, to end: AnyPoint<RawValue>) {
        self.start = start
        self.end = end
		
		start.keepUpdated(self)
		end.keepUpdated(self)
    }
    
    convenience init<P1: Point, P2: Point>(from start: P1, to end: P2) where P1.RawValue == RawValue, P2.RawValue == RawValue {
		self.init(from: AnyPoint(start), to: AnyPoint(end))
    }
}

extension LineSegment: Observer {
}

extension LineSegment: Drawable {
    func draw(in drawingUnit: AnyDrawingUnit<RawValue>) {
        drawingUnit.drawLineSegment(from: start, to: end, identifier: identifier)
        
        start.draw(in: drawingUnit)
        end.draw(in: drawingUnit)
    }
}

extension LineSegment: OneDimensional {
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
