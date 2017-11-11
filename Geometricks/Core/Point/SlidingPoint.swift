final class SlidingPoint<_RawValue: Real> {
    typealias RawValue = _RawValue
    
    private let floor: AnyOneDimensional<RawValue>
    
    private var fraction: RawValue? {
        didSet { rawPoint = fraction.flatMap(floor.point(at:)) }
    }
    
    private var rawPoint: RawPoint<RawValue>? {
        didSet { updateObservers() }
    }
    
    let observableStorage = ObservableStorage()
    
    init<T: OneDimensional>(oneDimensional: T, fraction: RawValue) where T.RawValue == RawValue {
        self.fraction = fraction
        floor = AnyOneDimensional(oneDimensional)
        rawPoint = oneDimensional.point(at: fraction)
        
        observe(floor)
    }
    
    deinit {
        stopObserving(floor)
    }
}

extension SlidingPoint: Observer {
    func update() {
        rawPoint = fraction.flatMap(floor.point(at:))
    }
}

extension SlidingPoint: OptionallyConvertibleToRawPoint {
    func makeRawPoint() -> RawPoint<RawValue>? {
        return rawPoint
    }
}

extension SlidingPoint: DraggablePoint {
    func takeOnValue(nearestTo point: RawPoint<RawValue>) {
        fraction = floor.fractionOfNearestPoint(to: point)
    }
}
