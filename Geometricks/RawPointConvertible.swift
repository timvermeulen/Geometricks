protocol ConvertibleFromRawPoint {
    associatedtype RawValue: FloatingPoint
    init(_ rawPoint: RawPoint<RawValue>)
}

protocol ConvertibleToRawPoint {
    associatedtype RawValue: FloatingPoint
    func makeRawPoint() -> RawPoint<RawValue>
}
