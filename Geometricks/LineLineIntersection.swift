final class LineLineIntersection<_RawValue: Real> {
	typealias RawValue = _RawValue
	
	private let lines: (Line<RawValue>, Line<RawValue>)
	
	private var fraction: RawValue? {
		didSet { rawPoint = fraction.flatMap(lines.0.point(at:)) }
	}
	
	private var rawPoint: RawPoint<RawValue>? {
		didSet { updateObservers() }
	}
	
	let observableStorage = ObservableStorage()
	
	init(_ line1: Line<RawValue>, _ line2: Line<RawValue>) {
		lines = (line1, line2)
		
		fraction = LineLineIntersection.getFraction(for: lines)
		rawPoint = fraction.flatMap(line1.point(at:))
		
		observe(line1, line2)
	}
}

extension LineLineIntersection: Observer {
	private static func getFraction(for lines: (Line<RawValue>, Line<RawValue>)) -> RawValue? {
		guard let rawLine0 = RawLine(lines.0), let rawLine1 = RawLine(lines.1) else { return nil }
		return Math.fractionsOfIntersections(line: rawLine0, line: rawLine1)?.0
	}
	
	func update() {
		fraction = LineLineIntersection.getFraction(for: lines)
	}
}

extension LineLineIntersection: ConvertibleToRawPoint {
	func makeRawPoint() -> RawPoint<RawValue>? {
		return rawPoint
	}
}

extension LineLineIntersection: Point {
}
