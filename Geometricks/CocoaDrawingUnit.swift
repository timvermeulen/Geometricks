import AppKit

final class CocoaDrawingUnit {
    typealias DrawingUnitRawValue = CGFloat
    
    private let defaultLineWidth: CGFloat
    private let defaultCurveColor: NSColor
    private let defaultPointRadius: CGFloat
    private let defaultPointBorderWidth: CGFloat
    private let defaultPointBorderColor: NSColor
    private let defaultPointFillColor: NSColor
    
    init(defaultLineWidth: CGFloat = 2, defaultCurveColor: NSColor = .black, defaultPointRadius: CGFloat = 3, defaultPointBorderWidth: CGFloat = 1, defaultPointBorderColor: NSColor = .black, defaultPointFillColor: NSColor = .white) {
        self.defaultLineWidth = defaultLineWidth
        self.defaultCurveColor = defaultCurveColor
        self.defaultPointRadius = defaultPointRadius
        self.defaultPointBorderWidth = defaultPointBorderWidth
        self.defaultPointBorderColor = defaultPointBorderColor
        self.defaultPointFillColor = defaultPointFillColor
    }
    
    private var lineWidths:   [Identifier: CGFloat] = [:]
    private var pointRadii:   [Identifier: CGFloat] = [:]
    private var strokeColors: [Identifier: NSColor] = [:]
    private var fillColors:   [Identifier: NSColor] = [:]
}

extension CocoaDrawingUnit {
    func setLineWidth(_ width: CGFloat, of lineSegment: LineSegment<CGFloat>) {
        lineWidths[lineSegment.identifier] = width
    }
    
    private func lineWidth(of identifier: Identifier) -> CGFloat {
        return lineWidths[identifier] ?? defaultLineWidth
    }
    
    func lineWidth(of lineSegment: LineSegment<CGFloat>) -> CGFloat {
        return lineWidth(of: lineSegment.identifier)
    }
}

extension CocoaDrawingUnit {
    func setCurveWidth(_ width: CGFloat, of curve: Curve<CGFloat>) {
        lineWidths[curve.identifier] = width
    }
    
    func curveWidth(of curve: Curve<CGFloat>) -> CGFloat {
        return lineWidth(of: curve.identifier)
    }
}

extension CocoaDrawingUnit {
    func setCurveColor(_ color: NSColor, of curve: Curve<CGFloat>) {
        strokeColors[curve.identifier] = color
    }
    
    private func curveColor(of identifier: Identifier) -> NSColor {
        return strokeColors[identifier] ?? defaultCurveColor
    }
    
    func curveColor(of curve: Curve<CGFloat>) -> NSColor {
        return curveColor(of: curve.identifier)
    }
}

extension CocoaDrawingUnit {
    func setPointRadius<P: Point>(_ radius: CGFloat, of point: P) {
        pointRadii[point.identifier] = radius
    }
    
    private func pointRadius(of identifier: Identifier) -> CGFloat {
        return pointRadii[identifier] ?? defaultPointRadius
    }
    
    func pointRadius<P: Point>(of point: P) -> CGFloat {
        return pointRadius(of: point.identifier)
    }
}

extension CocoaDrawingUnit {
    func setPointBorderWidth<P: Point>(_ width: CGFloat, of point: P) {
        lineWidths[point.identifier] = width
    }
    
    private func pointBorderWidth(of identifier: Identifier) -> CGFloat {
        return lineWidths[identifier] ?? defaultPointBorderWidth
    }
    
    func pointBorderWidth<P: Point>(of point: P) -> CGFloat {
        return pointBorderWidth(of: point.identifier)
    }
}

extension CocoaDrawingUnit {
    func setPointBorderColor<P: Point>(_ color: NSColor, of point: P) {
        strokeColors[point.identifier] = color
    }
    
    private func pointBorderColor(of identifier: Identifier) -> NSColor {
        return strokeColors[identifier] ?? defaultPointBorderColor
    }
    
    func pointBorderColor<P: Point>(of point: P) -> NSColor {
        return pointBorderColor(of: point.identifier)
    }
}

extension CocoaDrawingUnit {
    func setPointFillColor<P: Point>(_ color: NSColor, of point: P) {
        fillColors[point.identifier] = color
    }
    
    private func pointFillColor(of identifier: Identifier) -> NSColor {
        return fillColors[identifier] ?? defaultPointFillColor
    }
    
    func pointFillColor<P: Point>(of point: P) -> NSColor {
        return pointFillColor(of: point.identifier)
    }
}

extension CocoaDrawingUnit: DrawingUnit {
    func drawPoint(at location: NSPoint, identifier: Identifier) {
        pointBorderColor(of: identifier).setStroke()
        pointFillColor(of: identifier).setFill()
        
        let radius = pointRadius(of: identifier)
        let path = NSBezierPath(ovalIn: NSRect(x: location.x - radius, y: location.y - radius, width: radius * 2, height: radius * 2))
        path.lineWidth = pointBorderWidth(of: identifier)
        
        path.fill()
        path.stroke()
    }
    
    func drawLineSegment(from start: NSPoint, to end: NSPoint, identifier: Identifier) {
        let path = NSBezierPath.lineSegment(from: start, to: end)
        path.lineWidth = lineWidth(of: identifier)
        path.stroke()
    }
    
    func drawCurve(from start: NSPoint, to end: NSPoint, controlPoint1: NSPoint, controlPoint2: NSPoint, identifier: Identifier) {
        let path = NSBezierPath.curve(from: start, to: end, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        path.lineWidth = lineWidth(of: identifier)
        curveColor(of: identifier).setStroke()
        path.stroke()
    }
	
	func drawCircle(center: NSPoint, radius: CGFloat, identifier: Identifier) {
		let path = NSBezierPath(ovalIn: NSRect(x: center.x - radius, y: center.y - radius, width: radius * 2, height: radius * 2))
		path.stroke()
	}
}
