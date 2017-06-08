protocol ConvertibleFromRawPoint: RawValueType {
    init(_ rawPoint: RawPoint<RawValue>)
}

protocol ConvertibleToRawPoint: RawValueType {
    func makeRawPoint() -> RawPoint<RawValue>
}

extension ConvertibleToRawPoint {
    func distance(to point: RawPoint<RawValue>) -> RawValue {
        return makeRawPoint().distance(to: point)
    }
    
    func distance<T: ConvertibleToRawPoint>(to point: T) -> RawValue where T.RawValue == RawValue {
        return makeRawPoint().distance(to: point.makeRawPoint())
    }
}
