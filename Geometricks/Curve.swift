final class Curve<RawValue: FloatingPoint> {
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
		
		start.keepUpdated(self)
		end.keepUpdated(self)
		controlPoint1.keepUpdated(self)
		controlPoint2.keepUpdated(self)
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
    func draw(in drawingUnit: AnyDrawingUnit<RawValue>) {
        drawingUnit.drawCurve(from: start, to: end, controlPoint1: controlPoint1, controlPoint2: controlPoint2, identifier: identifier)
    }
}

extension Curve: OneDimensional {
    func point(at fraction: RawValue) -> RawPoint<RawValue> {
        return RawPoint.pointOnCurve(
			at: fraction,
			start: start.makeRawPoint(),
			end: end.makeRawPoint(),
			controlPoint1: controlPoint1.makeRawPoint(),
			controlPoint2: controlPoint2.makeRawPoint()
		)
    }
    
    func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue {
        return RawPoint.fractionOfProjectionOnCurve(
			of: point,
			start: start.makeRawPoint(),
			end: end.makeRawPoint(),
			controlPoint1: controlPoint1.makeRawPoint(),
			controlPoint2: controlPoint2.makeRawPoint()
		)
    }
}
