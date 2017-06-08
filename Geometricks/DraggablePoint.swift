protocol DraggablePoint: Point {
    func takeOnValue(nearestTo point: RawPoint<RawValue>)
}
