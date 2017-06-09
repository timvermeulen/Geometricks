final class LineLineIntersection<_RawValue: FloatingPoint> {
	typealias RawValue = _RawValue
	
	private let lines: (Line<RawValue>, Line<RawValue>)
	
	private var fraction: RawValue {
		didSet { rawPoint = lines.0.point(at: fraction) }
	}
	
	private var rawPoint: RawPoint<RawValue> {
		didSet { updateObservers() }
	}
	
	let observableStorage = ObservableStorage()
	
	init(_ line1: Line<RawValue>, _ line2: Line<RawValue>) {
		lines = (line1, line2)
		// TODO: clean up
		fraction = Math.fractionsOfLineIntersections(RawLine(line1), RawLine(line2))!.0
		rawPoint = line1.point(at: fraction)
		
		observe(line1, line2)
	}
}

extension LineLineIntersection: Observer {
	func update() {
		fraction = Math.fractionsOfLineIntersections(RawLine(lines.0), RawLine(lines.1))!.0
	}
}

extension LineLineIntersection: ConvertibleToRawPoint {
	func makeRawPoint() -> RawPoint<RawValue> {
		return rawPoint
	}
}

extension LineLineIntersection: Point {
}
