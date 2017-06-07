import CoreGraphics

extension CGFloat: FloatingPoint {
	var _sin: CGFloat { return sin(self) }
}
