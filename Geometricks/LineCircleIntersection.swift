final class LineCircleIntersection<_RawValue: Real> {
    typealias RawValue = _RawValue
    
    enum Option {
        case first, second
    }
    
    private let line: Line<RawValue>
    private let circle: Circle<RawValue>
    private let option: Option
    
    private var fraction: RawValue? {
        didSet { rawPoint = fraction.flatMap(line.point(at:)) }
    }
    
    private var rawPoint: RawPoint<RawValue>? {
        didSet { updateObservers() }
    }
    
    let observableStorage = ObservableStorage()
    
    init(line: Line<RawValue>, circle: Circle<RawValue>, option: Option) {
        self.line = line
        self.circle = circle
        self.option = option
        
        fraction = LineCircleIntersection.getFraction(line: line, circle: circle, option: option)
        rawPoint = fraction.flatMap(line.point(at:))
        
        observe(line, circle)
    }
    
    deinit {
        stopObserving(line, circle)
    }
}

extension LineCircleIntersection: Observer {
    private static func getFraction(line: Line<RawValue>, circle: Circle<RawValue>, option: Option) -> RawValue? {
        guard let rawLine = RawLine(line), let rawCircle = RawCircle(circle) else { return nil }
        return rawLine.fractionOfIntersection(with: rawCircle, option: option)
    }
    
    func update() {
        fraction = LineCircleIntersection.getFraction(line: line, circle: circle, option: option)
    }
}

extension LineCircleIntersection: OptionallyConvertibleToRawPoint {
    func makeRawPoint() -> RawPoint<RawValue>? {
        return rawPoint
    }
}

extension LineCircleIntersection: Point {
}
