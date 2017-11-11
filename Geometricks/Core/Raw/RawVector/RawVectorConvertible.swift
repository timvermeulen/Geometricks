protocol ConvertibleFromRawVector {
    associatedtype RawValue: Real
    
    init(_ rawVector: RawVector<RawValue>)
}

protocol ConvertibleToRawVector {
    associatedtype RawValue: Real
    
    func makeRawVector() -> RawVector<RawValue>
}
