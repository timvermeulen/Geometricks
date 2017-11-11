protocol ConvertibleFromRawRect {
    associatedtype RawValue: Real
    
    init(_ rawRect: RawRect<RawValue>)
}

protocol ConvertibleToRawRect {
    associatedtype RawValue: Real
    
    func makeRawRect() -> RawRect<RawValue>
}
