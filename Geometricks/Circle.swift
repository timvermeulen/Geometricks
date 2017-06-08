final class Circle<RawValue: FloatingPoint> {
	private let center: AnyPoint<RawValue>
	private let pointOnBoundary: AnyPoint<RawValue>
	
	let observableStorage = ObservableStorage()
	
	init(center: AnyPoint<RawValue>, pointOnBoundary: AnyPoint<RawValue>) {
		self.center = center
		self.pointOnBoundary = pointOnBoundary
		
		center.keepUpdated(self)
		pointOnBoundary.keepUpdated(self)
	}
	
	convenience init<P1: Point, P2: Point>(center: P1, pointOnBoundary: P2) where P1.DrawableRawValue == RawValue, P2.DrawableRawValue == RawValue {
		self.init(center: AnyPoint(center), pointOnBoundary: AnyPoint(pointOnBoundary))
	}
}

extension Circle: Observer {
}

extension Circle: Drawable {
	func draw(in drawingUnit: AnyDrawingUnit<RawValue>) {
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
//		print(point - rawCenter, (point - rawCenter).angleWithXAxis)
		return angle.mod(.tau)
	}
}
