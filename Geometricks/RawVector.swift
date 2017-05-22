struct RawVector<RawValue: FloatingPoint> {
    let changeInX, changeInY: RawValue
    
    var length: RawValue {
        return (changeInX * changeInX + changeInY * changeInY).squareRoot()
    }
}

extension RawVector: ConvertibleFromRawVector {
    init(_ rawVector: RawVector) {
        self = rawVector
    }
}

extension RawVector: ConvertibleToRawVector {
    func makeRawVector() -> RawVector {
        return self
    }
}
