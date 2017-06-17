final class Curve<_RawValue: Real> {
	typealias RawValue = _RawValue
	
    let start: AnyPoint<RawValue>
    let end: AnyPoint<RawValue>
    let controlPoint0: AnyPoint<RawValue>
    let controlPoint1: AnyPoint<RawValue>
	
	let observableStorage = ObservableStorage()
    
    init(from start: AnyPoint<RawValue>, to end: AnyPoint<RawValue>, controlPoint0: AnyPoint<RawValue>, controlPoint1: AnyPoint<RawValue>) {
        self.start = start
        self.end = end
        self.controlPoint0 = controlPoint0
        self.controlPoint1 = controlPoint1
		
		observe(start, end, controlPoint0, controlPoint1)
    }
    
    deinit {
        stopObserving(start, end, controlPoint0, controlPoint1)
    }
    
    convenience init<P1: Point, P2: Point, P3: Point, P4: Point>(from start: P1, to end: P2, controlPoint0: P3, controlPoint1: P4) where P1.RawValue == RawValue, P2.RawValue == RawValue, P3.RawValue == RawValue, P4.RawValue == RawValue {
		self.init(
			from: AnyPoint(start),
			to: AnyPoint(end),
			controlPoint0: AnyPoint(controlPoint0),
			controlPoint1: AnyPoint(controlPoint1)
		)
    }
}

extension Curve: Observer {
}

extension Curve: Drawable {
    func draw(in rect: RawRect<RawValue>?, using drawingUnit: AnyDrawingUnit<RawValue>) {
        drawingUnit.drawConvertibleCurve(from: start, to: end, controlPoint0: controlPoint0, controlPoint1: controlPoint1, identifier: identifier)
    }
}

extension Curve: OneDimensional {
    func point(at fraction: RawValue) -> RawPoint<RawValue>? {
		return RawCurve(self)?.point(at: fraction)
    }
    
    func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue? {
		return RawCurve(self)?.fractionOfNearestPoint(to: point)
    }
}
