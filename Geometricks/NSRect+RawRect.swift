import Foundation

extension NSRect: ConvertibleFromRawRect {
    typealias RawValue = CGFloat
    
    init(_ rawRect: RawRect<RawValue>) {
        self.init(origin: NSPoint(rawRect.origin), size: NSSize(rawRect.size))
    }
}

extension NSRect: ConvertibleToRawRect {
    func makeRawRect() -> RawRect<CGFloat> {
        return RawRect(origin: origin.makeRawPoint(), size: size.makeRawVector())
    }
}
