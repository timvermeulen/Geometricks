final class CircleCircleIntersection<_RawValue: Real> {
	typealias RawValue = _RawValue
	
	enum Option {
		case first, second
	}
	
	private let circles: (Circle<RawValue>, Circle<RawValue>)
	private let option: Option
	
	private var fraction: RawValue? {
		didSet { rawPoint = fraction.flatMap(circles.0.point(at:)) }
	}
	
	private var rawPoint: RawPoint<RawValue>? {
		didSet { updateObservers() }
	}
	
	let observableStorage = ObservableStorage()
	
	init(_ circle0: Circle<RawValue>, _ circle1: Circle<RawValue>, option: Option) {
		circles = (circle0, circle1)
		self.option = option
		
		fraction = CircleCircleIntersection.getFraction(circle0: circle0, circle1: circle1, option: option)
		rawPoint = fraction.flatMap(circle0.point(at:))
		
		observe(circle0, circle1)
	}
    
    private init(_ circle0: Circle<RawValue>, _ circle1: Circle<RawValue>, option: Option, fraction: RawValue?) {
        circles = (circle0, circle1)
        self.option = option
        self.fraction = fraction
        rawPoint = fraction.flatMap(circle0.point(at:))
        
        observe(circle0, circle1)
    }
	
	static func bothIntersections(_ circle0: Circle<RawValue>, _ circle1: Circle<RawValue>) -> (CircleCircleIntersection, CircleCircleIntersection) {
        guard
            let rawCircle0 = RawCircle(circle0),
            let rawCircle1 = RawCircle(circle1)
            else { return (CircleCircleIntersection(circle0, circle1, option: .first, fraction: nil), CircleCircleIntersection(circle0, circle1, option: .second, fraction: nil)) }
        
        let fractions = rawCircle0.fractionsOfIntersections(with: rawCircle1, makeFraction: circle0.fractionOfNearestPoint)
        
		return (
            CircleCircleIntersection(circle0, circle1, option: .first,  fraction: fractions?.0),
            CircleCircleIntersection(circle0, circle1, option: .second, fraction: fractions?.1)
		)
	}
}

extension CircleCircleIntersection: Observer {
	private static func getFraction(circle0: Circle<RawValue>, circle1: Circle<RawValue>, option: Option) -> RawValue? {
		guard
			let rawCircle0 = RawCircle(circle0),
			let rawCircle1 = RawCircle(circle1)
			else { return nil }
		
		return rawCircle0.fractionOfIntersection(with: rawCircle1, option: option, makeFraction: circle0.fractionOfNearestPoint)
	}
	
	func update() {
		fraction = CircleCircleIntersection.getFraction(circle0: circles.0, circle1: circles.1, option: option)
	}
}

extension CircleCircleIntersection: ConvertibleToRawPoint {
	func makeRawPoint() -> RawPoint<RawValue>? {
		return rawPoint
	}
}

extension CircleCircleIntersection: Point {
}
