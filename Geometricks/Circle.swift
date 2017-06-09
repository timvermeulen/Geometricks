final class Circle<_RawValue: FloatingPoint> {
	typealias RawValue = _RawValue
	
	private let center: AnyPoint<RawValue>
	private let pointOnBoundary: AnyPoint<RawValue>
	
	let observableStorage = ObservableStorage()
	
	init(center: AnyPoint<RawValue>, pointOnBoundary: AnyPoint<RawValue>) {
		self.center = center
		self.pointOnBoundary = pointOnBoundary
		
		observe(center, pointOnBoundary)
	}
	
	convenience init<P1: Point, P2: Point>(center: P1, pointOnBoundary: P2) where P1.RawValue == RawValue, P2.RawValue == RawValue {
		self.init(center: AnyPoint(center), pointOnBoundary: AnyPoint(pointOnBoundary))
	}
}

extension Circle: Observer {
}

extension Circle: Drawable {
	func draw(in rect: RawRect<RawValue>?, using drawingUnit: AnyDrawingUnit<RawValue>) {
		drawingUnit.drawCircle(center: center, radius: pointOnBoundary.distance(to: center), identifier: identifier)
	}
}

extension Circle: OneDimensional {
	func point(at fraction: RawValue) -> RawPoint<RawValue> {
		return pointOnBoundary.makeRawPoint().rotated(by: fraction, around: center.makeRawPoint())
	}
	
	func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue {
		let rawCenter = center.makeRawPoint()
		let angle = (point - rawCenter).angleWithXAxis - (pointOnBoundary.makeRawPoint() - rawCenter).angleWithXAxis
		return angle.mod(.tau)
	}
}
