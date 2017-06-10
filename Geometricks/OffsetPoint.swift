final class OffsetPoint<_RawValue: FloatingPoint> {
	typealias RawValue = _RawValue
	
	private let anchor: AnyPoint<RawValue>
	private var offset: RawVector<RawValue>?
	private var rawPoint: RawPoint<RawValue>?
	
	let observableStorage = ObservableStorage()
	
	init(anchor: AnyPoint<RawValue>, offset: RawVector<RawValue>) {
		self.anchor = anchor
		self.offset = offset
		rawPoint = anchor.makeRawPoint().map { $0 + offset }
		
		observe(anchor)
	}
	
	convenience init<P: Point, T: ConvertibleToRawVector>(anchor: P, offset: T) where P.RawValue == RawValue, T.RawValue == RawValue {
		self.init(anchor: AnyPoint(anchor), offset: offset.makeRawVector())
	}
}

extension OffsetPoint: Observer {
	func update() {
		guard let rawAnchor = anchor.makeRawPoint(), let offset = offset else { return }
		rawPoint = rawAnchor + offset
	}
}

extension OffsetPoint: ConvertibleToRawPoint {
	func makeRawPoint() -> RawPoint<RawValue>? {
		return rawPoint
	}
}

extension OffsetPoint: DraggablePoint {
	func takeOnValue(nearestTo point: RawPoint<RawValue>) {
		offset = anchor.makeRawPoint().map { point - $0 }
		rawPoint = point
	}
}
