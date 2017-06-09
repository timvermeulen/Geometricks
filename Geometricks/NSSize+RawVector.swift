import Foundation

extension NSSize: ConvertibleFromRawVector {
	typealias RawValue = CGFloat
	
	init(_ rawVector: RawVector<RawValue>) {
		self.init(width: rawVector.changeInX, height: rawVector.changeInY)
	}
}

extension NSSize: ConvertibleToRawVector {
	func makeRawVector() -> RawVector<CGFloat> {
		return RawVector(changeInX: width, changeInY: height)
	}
}
