protocol ConvertibleFromRawPoint {
    associatedtype RawValue: Real
    
    init(_ rawPoint: RawPoint<RawValue>)
}

protocol OptionallyConvertibleToRawPoint {
    associatedtype RawValue: Real
    
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
