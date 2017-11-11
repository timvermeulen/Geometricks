struct TwoTwoMatrix<RawValue: Real> {
    private let topLeft, topRight, bottomLeft, bottomRight: RawValue
}

extension TwoTwoMatrix {
    init(_ vector1: RawVector<RawValue>, _ vector2: RawVector<RawValue>) {
        topLeft     = vector1.changeInX
        bottomLeft  = vector1.changeInY
        topRight    = vector2.changeInX
        bottomRight = vector2.changeInY
    }
    
    static func * (left: RawValue, right: TwoTwoMatrix) -> TwoTwoMatrix {
        return TwoTwoMatrix(topLeft: left * right.topLeft, topRight: left * right.topRight, bottomLeft: left * right.bottomLeft, bottomRight: left * right.bottomRight)
    }
    
    static func * (left: RawVector<RawValue>, right: TwoTwoMatrix) -> RawVector<RawValue> {
        return RawVector(
            changeInX: left.changeInX * right.topLeft    + left.changeInY * right.topRight,
            changeInY: left.changeInX * right.bottomLeft + left.changeInY * right.bottomRight
        )
    }
    
    var determinant: RawValue {
        return topLeft * bottomRight - topRight * bottomLeft
    }
    
    var inverse: TwoTwoMatrix? {
        let determinant = self.determinant
        guard determinant != 0 else { return nil }
        
        return (1 / determinant) * TwoTwoMatrix(topLeft: bottomRight, topRight: -topRight, bottomLeft: -bottomLeft, bottomRight: topLeft)
    }
}
