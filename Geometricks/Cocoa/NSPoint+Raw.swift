import Foundation

extension NSPoint: ConvertibleFromRawPoint {
    init(_ rawPoint: RawPoint<CGFloat>) {
        x = rawPoint.x
        y = rawPoint.y
    }
}

extension NSPoint: ConvertibleToRawPoint {
    func makeRawPoint() -> RawPoint<CGFloat> {
        return RawPoint(x: x, y: y)
    }
}

extension NSPoint: ConvertibleFromRawVector {
    init(_ rawVector: RawVector<CGFloat>) {
        x = rawVector.changeInX
        y = rawVector.changeInY
    }
}

extension NSPoint: ConvertibleToRawVector {
    func makeRawVector() -> RawVector<CGFloat> {
        return RawVector(changeInX: x, changeInY: y)
    }
}
