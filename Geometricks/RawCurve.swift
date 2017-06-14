struct RawCurve<RawValue: Real> {
	let line: RawLine<RawValue>
	let controlPoints: (RawPoint<RawValue>, RawPoint<RawValue>)
	
	var start: RawPoint<RawValue> { return line.start }
	var end: RawPoint<RawValue> { return line.end }
}

extension RawCurve {
	init?(_ curve: Curve<RawValue>) {
		guard
			let rawStart = curve.start.makeRawPoint(),
			let rawEnd = curve.end.makeRawPoint(),
			let rawControlPoint0 = curve.controlPoint0.makeRawPoint(),
			let rawControlPoint1 = curve.controlPoint1.makeRawPoint()
			else { return nil }
		
		line = RawLine(start: rawStart, end: rawEnd)
		controlPoints = (rawControlPoint0, rawControlPoint1)
	}
}
