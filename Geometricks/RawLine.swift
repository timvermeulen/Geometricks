struct RawLine<RawValue: FloatingPoint> {
	let start: RawPoint<RawValue>
	let end: RawPoint<RawValue>
	
	var delta: RawVector<RawValue> {
		return end - start
	}
}

extension RawLine {
	init<P1: ConvertibleToRawPoint, P2: ConvertibleToRawPoint>(start: P1, end: P2) where P1.RawValue == RawValue, P2.RawValue == RawValue {
		self.init(start: start.makeRawPoint(), end: end.makeRawPoint())
	}
	
	// TODO: more generic?
	
	init(_ line: Line<RawValue>) {
		self.init(start: line.start, end: line.end)
	}
	
	init(_ lineSegment: LineSegment<RawValue>) {
		self.init(start: lineSegment.start, end: lineSegment.end)
	}
}
