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
	
	init(_ line0: Line<RawValue>, _ line1: Line<RawValue>) {
		lines = (line0, line1)
		
		fraction = LineLineIntersection.getFraction(for: lines)
		rawPoint = fraction.flatMap(line0.point(at:))
		
		observe(line0, line1)
	}
    
    deinit {
        stopObserving(lines.0, lines.1)
    }
}

extension LineLineIntersection: Observer {
	private static func getFraction(for lines: (Line<RawValue>, Line<RawValue>)) -> RawValue? {
		guard let rawLine0 = RawLine(lines.0), let rawLine1 = RawLine(lines.1) else { return nil }
		return rawLine0.fractionsOfIntersections(with: rawLine1)?.0
	}
	
	func update() {
		fraction = LineLineIntersection.getFraction(for: lines)
	}
}

extension LineLineIntersection: OptionallyConvertibleToRawPoint {
	func makeRawPoint() -> RawPoint<RawValue>? {
		return rawPoint
	}
}

extension LineLineIntersection: Point {
}
