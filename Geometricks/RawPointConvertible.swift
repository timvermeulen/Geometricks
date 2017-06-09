protocol ConvertibleFromRawPoint: RawValueType {
    init(_ rawPoint: RawPoint<RawValue>)
}

protocol ConvertibleToRawPoint: RawValueType {
    func makeRawPoint() -> RawPoint<RawValue>?
}

extension ConvertibleToRawPoint {
    func distance(to point: RawPoint<RawValue>) -> RawValue? {
		guard let rawPoint =  makeRawPoint() else { return nil }
		// TODO: report bug
		let distance = rawPoint.distance(to: point)
		return distance
    }
    
    func distance<T: ConvertibleToRawPoint>(to point: T) -> RawValue? where T.RawValue == RawValue {
		return point.makeRawPoint().flatMap { makeRawPoint()?.distance(to: $0) }
    }
}
