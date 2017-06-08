protocol ConvertibleFromRawVector: RawValueType {
    init(_ rawVector: RawVector<RawValue>)
}

protocol ConvertibleToRawVector: RawValueType {
    func makeRawVector() -> RawVector<RawValue>
}
