struct RawRect<_RawValue: Real> {
	typealias RawValue = _RawValue
	
	let origin: RawPoint<RawValue>
	let size: RawVector<RawValue>
	
	var minX: RawValue { return origin.x + min(0, size.changeInX) }
	var maxX: RawValue { return origin.x + max(0, size.changeInX) }
	var minY: RawValue { return origin.y + min(0, size.changeInY) }
	var maxY: RawValue { return origin.y + max(0, size.changeInY) }
	
	var bottomLeft:  RawPoint<RawValue> { return RawPoint(x: minX, y: minY) }
	var topLeft:     RawPoint<RawValue> { return RawPoint(x: minX, y: maxY) }
	var topRight:    RawPoint<RawValue> { return RawPoint(x: maxX, y: maxY) }
	var bottomRight: RawPoint<RawValue> { return RawPoint(x: maxX, y: minY) }
	
	var sides: (RawLine<RawValue>, RawLine<RawValue>, RawLine<RawValue>, RawLine<RawValue>) {
		return (
			RawLine(start: bottomLeft, end: topLeft),
			RawLine(start: topLeft, end: topRight),
			RawLine(start: topRight, end: bottomRight),
			RawLine(start: bottomRight, end: bottomLeft)
		)
	}
}

extension RawRect: ConvertibleFromRawRect {
	init(_ rawRect: RawRect<RawValue>) {
		self = rawRect
	}
}

extension RawRect: ConvertibleToRawRect {
	func makeRawRect() -> RawRect<RawValue> {
		return self
	}
}
