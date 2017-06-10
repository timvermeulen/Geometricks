final class Line<_RawValue: FloatingPoint> {
	typealias RawValue = _RawValue
	
	let start: AnyPoint<RawValue>
	let end: AnyPoint<RawValue>
	
	let observableStorage = ObservableStorage()
	
	init(from start: AnyPoint<RawValue>, to end: AnyPoint<RawValue>) {
		self.start = start
		self.end = end
		
		observe(start, end)
	}
	
	convenience init<P1: Point, P2: Point>(from start: P1, to end: P2) where P1.RawValue == RawValue, P2.RawValue == RawValue {
		self.init(from: AnyPoint(start), to: AnyPoint(end))
	}
}

extension Line: Observer {
}

extension Line: Drawable {
	func draw(in rect: RawRect<RawValue>?, using drawingUnit: AnyDrawingUnit<RawValue>) {
		guard
			let rect = rect,
			let rawLine = RawLine(self),
			let fractions = Math.fractionsOfLine(rawLine, intersectingWith: rect),
			let lineStart = point(at: fractions.0),
			let lineEnd = point(at: fractions.1)
			else { return }
		
		
		drawingUnit.drawLine(from: lineStart, to: lineEnd, identifier: identifier)
	}
}

extension Line: OneDimensional {
	func point(at fraction: RawValue) -> RawPoint<RawValue>? {
		return RawLine(self).map { .point(on: $0, at: fraction) }
	}
	
	func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue? {
		return RawLine(self).map { Math.fractionOfProjection(of: point, on: $0) }
	}
}
