protocol Point: Drawable, ConvertibleToRawPoint {
    var identifier: ObjectIdentifier { get }
}

extension Point where Self: AnyObject {
    var identifier: ObjectIdentifier {
        return ObjectIdentifier(self)
    }
}
