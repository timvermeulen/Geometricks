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
		return .some(rawPoint.distance(to: point))
    }
    
    func distance<T: ConvertibleToRawPoint>(to point: T) -> RawValue? where T.RawValue == RawValue {
		return point.makeRawPoint().flatMap { makeRawPoint()?.distance(to: $0) }
    }
}

protocol AlwaysConvertibleToRawPoint: ConvertibleToRawPoint {
	func makeRawPoint() -> RawPoint<RawValue>
}

extension AlwaysConvertibleToRawPoint {
	func distance(to point: RawPoint<RawValue>) -> RawValue {
		return makeRawPoint().distance(to: point)
	}
	
	func distance<T: AlwaysConvertibleToRawPoint>(to point: T) -> RawValue where T.RawValue == RawValue {
		return distance(to: point.makeRawPoint())
	}
	
	func makeRawPoint() -> RawPoint<RawValue>? {
		return .some(makeRawPoint())
	}
}
