struct RawLine<RawValue: FloatingPoint> {
	let start: RawPoint<RawValue>
	let end: RawPoint<RawValue>
	
	var delta: RawVector<RawValue> {
		return end - start
	}
	
	var midPoint: RawPoint<RawValue> {
		return start + (1 / 2) * delta
	}
	
	var perpendicularBisector: RawLine {
		let midPoint = self.midPoint
		let delta = self.delta
		let vector = RawVector(changeInX: delta.changeInX, changeInY: -delta.changeInY)
		
		return RawLine(start: midPoint, delta: vector)
	}
}

extension RawLine {
	init(start: RawPoint<RawValue>, delta: RawVector<RawValue>) {
		self.start = start
		end = start + delta
	}
	
	init?<P1: ConvertibleToRawPoint, P2: ConvertibleToRawPoint>(start: P1, end: P2) where P1.RawValue == RawValue, P2.RawValue == RawValue {
		guard
			let rawStart = start.makeRawPoint(),
			let rawEnd = end.makeRawPoint()
			else { return nil }
		
		self.init(start: rawStart, end: rawEnd)
	}
	
	// TODO: more generic?
	
	init?(_ line: Line<RawValue>) {
		self.init(start: line.start, end: line.end)
	}
	
	init?(_ lineSegment: LineSegment<RawValue>) {
		self.init(start: lineSegment.start, end: lineSegment.end)
	}
}
