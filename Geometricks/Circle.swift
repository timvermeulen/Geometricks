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
		guard let radius = pointOnBoundary.distance(to: center) else { return }
		
		drawingUnit.drawCircle(center: center, radius: radius, identifier: identifier)
	}
}

extension Circle: OneDimensional {
	func point(at fraction: RawValue) -> RawPoint<RawValue>? {
		guard let rawCenter = center.makeRawPoint() else { return nil }
		
		return pointOnBoundary.makeRawPoint()?.rotated(by: fraction, around: rawCenter)
	}
	
	func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue? {
		guard
			let rawCenter = center.makeRawPoint(),
			let rawPointOnBoundary = pointOnBoundary.makeRawPoint()
			else { return nil }
		
		let angle = (point - rawCenter).angleWithXAxis - (rawPointOnBoundary - rawCenter).angleWithXAxis
		return angle.mod(.tau)
	}
}
