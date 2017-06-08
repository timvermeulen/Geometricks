protocol ConvertibleFromRawVector {
    associatedtype ConvertibleFromRawVectorRawValue: FloatingPoint
    init(_ rawVector: RawVector<ConvertibleFromRawVectorRawValue>)
}

protocol ConvertibleToRawVector {
    associatedtype ConvertibleToRawVectorRawValue: FloatingPoint
    func makeRawVector() -> RawVector<ConvertibleToRawVectorRawValue>
}
