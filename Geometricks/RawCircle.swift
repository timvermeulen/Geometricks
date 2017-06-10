struct RawCircle<RawValue: FloatingPoint> {
	let center: RawPoint<RawValue>
	let radius: RawValue
}

extension RawCircle {
	init?(_ circle: Circle<RawValue>) {
		guard let rawCenter = circle.center.makeRawPoint(), let rawPointOnBoundary = circle.pointOnBoundary.makeRawPoint() else { return nil }
		
		center = rawCenter
		radius = rawCenter.distance(to: rawPointOnBoundary)
	}
}
