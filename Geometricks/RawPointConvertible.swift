protocol ConvertibleFromRawPoint: RawValueType {
    init(_ rawPoint: RawPoint<RawValue>)
}

protocol ConvertibleToRawPoint: RawValueType {
    func makeRawPoint() -> RawPoint<RawValue>?
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
