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
    func makeRawPoint() -> RawPoint<RawValue>? {
        return .some(makeRawPoint())
	}
}
