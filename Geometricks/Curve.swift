final class Curve<_RawValue: Real> {
	typealias RawValue = _RawValue
	
    let start: AnyPoint<RawValue>
    let end: AnyPoint<RawValue>
    let controlPoint0: AnyPoint<RawValue>
    let controlPoint1: AnyPoint<RawValue>
	
	let observableStorage = ObservableStorage()
    
    init(from start: AnyPoint<RawValue>, to end: AnyPoint<RawValue>, controlPoint1: AnyPoint<RawValue>, controlPoint2: AnyPoint<RawValue>) {
        self.start = start
        self.end = end
        self.controlPoint0 = controlPoint1
        self.controlPoint1 = controlPoint2
		
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
        drawingUnit.drawCurve(from: start, to: end, controlPoint1: controlPoint0, controlPoint2: controlPoint1, identifier: identifier)
    }
}

extension Curve: OneDimensional {
    func point(at fraction: RawValue) -> RawPoint<RawValue>? {
		guard let rawCurve = RawCurve(self) else { return nil }
		return .point(on: rawCurve, at: fraction)
    }
    
    func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue? {
		guard let rawCurve = RawCurve(self) else { return nil }
		return Math.fractionOfProjection(of: point, on: rawCurve)
    }
}
