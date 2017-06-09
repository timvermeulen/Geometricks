struct RawCircle<RawValue: FloatingPoint> {
	let center: RawPoint<RawValue>
	let radius: RawValue
}

extension RawCircle {
	init?(_ circle: Circle<RawValue>) {
		guard let center = circle.center.makeRawPoint(), let radius = circle.radius else { return nil }
		
		self.center = center
		self.radius = radius
	}
}
