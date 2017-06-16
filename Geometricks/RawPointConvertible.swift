protocol ConvertibleFromRawPoint: RawValueType {
    init(_ rawPoint: RawPoint<RawValue>)
}

protocol OptionallyConvertibleToRawPoint: RawValueType {
    func makeRawPoint() -> RawPoint<RawValue>?
}

protocol ConvertibleToRawPoint: OptionallyConvertibleToRawPoint {
	func makeRawPoint() -> RawPoint<RawValue>
}

extension ConvertibleToRawPoint {
    func makeRawPoint() -> RawPoint<RawValue>? {
        return .some(makeRawPoint())
	}
}
