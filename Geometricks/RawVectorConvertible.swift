protocol ConvertibleFromRawVector {
    associatedtype RawValue: FloatingPoint
    init(_ rawVector: RawVector<RawValue>)
}

protocol ConvertibleToRawVector {
    associatedtype RawValue: FloatingPoint
    func makeRawVector() -> RawVector<RawValue>
}
