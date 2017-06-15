final class Line<_RawValue: Real> {
	typealias RawValue = _RawValue
	
	let start: AnyPoint<RawValue>
	let end: AnyPoint<RawValue>
	
	let observableStorage = ObservableStorage()
	
	init(from start: AnyPoint<RawValue>, to end: AnyPoint<RawValue>) {
		self.start = start
		self.end = end
		
		observe(start, end)
	}
    
    deinit {
        stopObserving(start, end)
    }
	
	convenience init<P1: Point, P2: Point>(from start: P1, to end: P2) where P1.RawValue == RawValue, P2.RawValue == RawValue {
		self.init(from: AnyPoint(start), to: AnyPoint(end))
	}
}

extension Line {
	static func perpendicularBisector(_ point0: AnyPoint<RawValue>, _ point1: AnyPoint<RawValue>) -> Line {
		let circle0 = Circle(center: point0, pointOnBoundary: point1)
		let circle1 = Circle(center: point1, pointOnBoundary: point0)
		
		let intersection0 = CircleCircleIntersection(circle0, circle1, option: .first)
		let intersection1 = CircleCircleIntersection(circle0, circle1, option: .second)
		
		return Line(from: intersection0, to: intersection1)
	}
	
	static func perpendicularBisector<P0: Point, P1: Point>(_ point0: P0, _ point1: P1) -> Line where P0.RawValue == RawValue, P1.RawValue == RawValue {
		return perpendicularBisector(AnyPoint(point0), AnyPoint(point1))
	}
}

extension Line: Observer {
}

extension Line: Drawable {
	func draw(in rect: RawRect<RawValue>?, using drawingUnit: AnyDrawingUnit<RawValue>) {
		guard
			let rect = rect,
			let rawLine = RawLine(self),
            let fractions = rawLine.fractionsOfIntersections(with: rect),
			let lineStart = point(at: fractions.0),
			let lineEnd = point(at: fractions.1)
			else { return }
		
		
		drawingUnit.drawLine(from: lineStart, to: lineEnd, identifier: identifier)
	}
}

extension Line: OneDimensional {
	func point(at fraction: RawValue) -> RawPoint<RawValue>? {
		return RawLine(self).map { $0.point(at: fraction) }
	}
	
	func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue? {
		return RawLine(self).map { $0.fractionOfProjection(of: point) }
	}
}
