final class Circle<_RawValue: Real> {
	typealias RawValue = _RawValue
	
	let center: AnyPoint<RawValue>
	let pointOnBoundary: AnyPoint<RawValue>
	
	let observableStorage = ObservableStorage()
	
	init(center: AnyPoint<RawValue>, pointOnBoundary: AnyPoint<RawValue>) {
		self.center = center
		self.pointOnBoundary = pointOnBoundary
		
		observe(center, pointOnBoundary)
	}
    
    deinit {
        stopObserving(center, pointOnBoundary)
    }
	
	convenience init<P1: Point, P2: Point>(center: P1, pointOnBoundary: P2) where P1.RawValue == RawValue, P2.RawValue == RawValue {
		self.init(center: AnyPoint(center), pointOnBoundary: AnyPoint(pointOnBoundary))
	}
}

extension Circle: Observer {
}

extension Circle: Drawable {
	func draw(in rect: RawRect<RawValue>?, using drawingUnit: AnyDrawingUnit<RawValue>) {
		guard let radius = RawCircle(self)?.radius else { return }
		drawingUnit.drawConvertibleCircle(center: center, radius: radius, identifier: identifier)
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
		
		let angle = point.angle(relativeTo: rawCenter) - rawPointOnBoundary.angle(relativeTo: rawCenter)
		return angle.mod(.tau)
	}
}
