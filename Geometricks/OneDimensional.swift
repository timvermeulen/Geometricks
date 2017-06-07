protocol OneDimensional: Observable {
    associatedtype RawValue: FloatingPoint
    
    func point(at fraction: RawValue) -> RawPoint<RawValue>
    func fractionOfNearestPoint(to point: RawPoint<RawValue>) -> RawValue
}

//extension OneDimensional {
//	func nearestPoint(to point: RawPoint<RawValue>) -> RawPoint<RawValue> {
//		return self.point(at: fractionOfNearestPoint(to: point))
//	}
//}
