final class Curve<_RawValue: FloatingPoint> {
	typealias RawValue = _RawValue
	
    private let start: AnyPoint<RawValue>
    private let end: AnyPoint<RawValue>
    private let controlPoint1: AnyPoint<RawValue>
    private let controlPoint2: AnyPoint<RawValue>
	
	let observableStorage = ObservableStorage()
    
    init(from start: AnyPoint<RawValue>, to end: AnyPoint<RawValue>, controlPoint1: AnyPoint<RawValue>, controlPoint2: AnyPoint<RawValue>) {
        self.start = start
        self.end = end
        self.controlPoint1 = controlPoint1
        self.controlPoint2 = controlPoint2
		
		observe(start, end, controlPoint1, controlPoint2)
    }
    
    convenience init<P1: Point, P2: Point, P3: Point, P4: Point>(from start: P1, to end: P2, controlPoint1: P3, controlPoint2: P4) where P1.RawValue == RawValue, P2.RawValue == RawValue, P3.RawValue == RawValue, P4.RawValue == RawValue {
		self.init(
			from: AnyPoint(start),
			to: AnyPoint(end),
			controlPoint1: AnyPoint(controlPoint1),
			controlPoint2: AnyPoint(controlPoint2)
		)
    }
}

extension Curve: Observer {
}

extension Curve: Drawable {
    func draw(in rect: RawRect<RawValue>?, using drawingUnit: AnyDrawingUnit<RawValue>) {
        drawingUnit.drawCurve(from: start, to: end, controlPoint1: controlPoint1, controlPoint2: controlPoint2, identifier: identifier)
    }
}

extension Curve: OneDimensional {
    func point(at fraction: RawValue) -> RawPoint<RawValue>? {
		// TODO: raw curve type?
		
		guard
			let rawStart = start.makeRawPoint(),
			let rawEnd = end.makeRawPoint(),
			let rawControl1 = controlPoint1.makeRawPoint(),
			let rawControl2 = controlPoint2.makeRawPoint()
			else { return nil }
		
        return .pointOnCurve(
			at: fraction,
			start: rawStart,
			end: rawEnd,
			controlPoint1: rawControl1,
			controlPoint2: rawControl2
		)
    }
    
    func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue? {
		guard
			let rawStart = start.makeRawPoint(),
			let rawEnd = end.makeRawPoint(),
			let rawControl1 = controlPoint1.makeRawPoint(),
			let rawControl2 = controlPoint2.makeRawPoint()
			else { return nil }
		
        return Math.fractionOfProjectionOnCurve(
			of: point,
			start: rawStart,
			end: rawEnd,
			controlPoint1: rawControl1,
			controlPoint2: rawControl2
		)
    }
}
