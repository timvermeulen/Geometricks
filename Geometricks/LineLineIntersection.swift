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
		fraction = Math.fractionsOfLineIntersections(line1: (line1.start.makeRawPoint(), line1.end.makeRawPoint()), line2: (line2.start.makeRawPoint(), line2.end.makeRawPoint()))!.0
		rawPoint = line1.point(at: fraction)
		
		observe(line1, line2)
	}
}

extension LineLineIntersection: Observer {
	func update() {
		fraction = Math.fractionsOfLineIntersections(line1: (lines.0.start.makeRawPoint(), lines.0.end.makeRawPoint()), line2: (lines.1.start.makeRawPoint(), lines.1.end.makeRawPoint()))!.0
	}
}

extension LineLineIntersection: ConvertibleToRawPoint {
	func makeRawPoint() -> RawPoint<RawValue> {
		return rawPoint
	}
}

extension LineLineIntersection: Point {
}
