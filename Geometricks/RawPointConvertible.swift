protocol ConvertibleFromRawPoint {
    associatedtype ConvertibleFromRawPointRawValue: FloatingPoint
    init(_ rawPoint: RawPoint<ConvertibleFromRawPointRawValue>)
}

protocol ConvertibleToRawPoint {
    associatedtype ConvertibleToRawPointRawValue: FloatingPoint
    func makeRawPoint() -> RawPoint<ConvertibleToRawPointRawValue>
}

extension ConvertibleToRawPoint {
    func distance(to point: RawPoint<ConvertibleToRawPointRawValue>) -> ConvertibleToRawPointRawValue {
        return makeRawPoint().distance(to: point)
    }
    
    func distance<T: ConvertibleToRawPoint>(to point: T) -> ConvertibleToRawPointRawValue where T.ConvertibleToRawPointRawValue == ConvertibleToRawPointRawValue {
        return makeRawPoint().distance(to: point.makeRawPoint())
    }
}
