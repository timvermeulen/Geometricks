struct RawCircle<RawValue: Real> {
	let center: RawPoint<RawValue>
	let radius: RawValue
}

extension RawCircle {
	init?(_ circle: Circle<RawValue>) {
		guard let rawCenter = circle.center.makeRawPoint(), let rawPointOnBoundary = circle.pointOnBoundary.makeRawPoint() else { return nil }
		
		center = rawCenter
		radius = rawCenter.distance(to: rawPointOnBoundary)
	}
    
    func encloses(_ other: RawCircle) -> Bool {
        return radius > center.distance(to: other.center) + other.radius
    }
}
