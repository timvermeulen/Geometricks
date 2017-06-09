final class LineSegment<_RawValue: FloatingPoint> {
	typealias RawValue = _RawValue
	
    private let start: AnyPoint<RawValue>
    private let end: AnyPoint<RawValue>
	
	let observableStorage = ObservableStorage()
    
    init(from start: AnyPoint<RawValue>, to end: AnyPoint<RawValue>) {
        self.start = start
        self.end = end
		
		observe(start, end)
    }
    
    convenience init<P1: Point, P2: Point>(from start: P1, to end: P2) where P1.RawValue == RawValue, P2.RawValue == RawValue {
		self.init(from: AnyPoint(start), to: AnyPoint(end))
    }
}

extension LineSegment: Observer {
}

extension LineSegment: Drawable {
    func draw(in rect: RawRect<RawValue>?, using drawingUnit: AnyDrawingUnit<RawValue>) {
        drawingUnit.drawLine(from: start, to: end, identifier: identifier)
    }
}

extension LineSegment: OneDimensional {
    func point(at fraction: RawValue) -> RawPoint<RawValue> {
        let rawStart = start.makeRawPoint()
        let rawEnd = end.makeRawPoint()
        
        return rawStart + fraction * (rawEnd - rawStart)
    }
    
    func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue {
		let fraction = Math.fractionOfProjection(of: point, onLineBetween: start.makeRawPoint(), and: end.makeRawPoint())
		return fraction.clamped(to: 0...1)
    }
}
